Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD361235F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 20:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLQTxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 14:53:24 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36010 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLQTxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 14:53:23 -0500
Received: by mail-qv1-f65.google.com with SMTP id m14so4134881qvl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 11:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbG94/l7eYJmeX3PI75afEHp0QRT/4uLVyCB3ekhvMI=;
        b=ZtglN4WsQqgjndBl+K2u1V3QfeT7JiFFSPgTYAN9sKdYokHFwIz6TYVgs7NzBUUpFY
         09X0whiU2o5yf6y0c+fpYgYB4LbHWlFovrsKqFFsMMcfjMcEuRKgVftq5khqE1d0cHJe
         3huNqPU1v2/zMoIJQMNovTzoaSdoFuwbuCTa5wvSyUPLvUov2IE9jxTPTZx5ElVqvmwm
         Fuo/JBg26wMS4PzIDbnVK2xm2Av2xoOXBNV4giw/GNq76/0yh1O5ux4JX/GkwjYWB65V
         J890S5L455Qk8XevH/vPoi0hSdBXGmceDUi5BNJQdzov0+n+QLNKRrAYLI3uvpc5eyEQ
         sSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbG94/l7eYJmeX3PI75afEHp0QRT/4uLVyCB3ekhvMI=;
        b=gLHg1Y4dyg2d8Bng6r2MJCn+O5wxvjJrAvodyMJqZ/SllK79lH488RXfDbT0SQ5x3s
         kpACXFuto3u5Slg6FDoQ3GYXkw7ipqwPfEdOoU36HXyxkb7r/MQl91Ng5+TDwaiB+HR+
         Aq191qK7xm+DURAY3jsCq+LQRu2FjFYaRmho1FwmwT2q8cF1zVRkxqmv3kTrPouFGdQD
         VxjKyRufR8JbjsQbDBmawgTXN0fgPHOshAfThhn4fL+mZ6Rr3NJf1bqWoBw4ce3O1rl6
         GewaNKz1qd7B9crl1XzGuxkXZoYKRiUUPoWnoS6H3gpndW8A163L1yEXhdb4JJIlGF10
         a/0g==
X-Gm-Message-State: APjAAAWLPjEuiboo23ERPy1NeW0+TvkWGl1Vx5F6eiJpyQQAO+DiRFga
        MV6XhqW1mIMfOuGNtqDaosVC1g==
X-Google-Smtp-Source: APXvYqxWGKdU4BMYe/vRTXYnQ95tuRZprGy/SbWenDNKz4s5hajEqYJPHM0YKoNPeKux/Uk+MI7QGA==
X-Received: by 2002:ad4:4b6a:: with SMTP id m10mr6239211qvx.116.1576612403006;
        Tue, 17 Dec 2019 11:53:23 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id q35sm8572197qta.19.2019.12.17.11.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:53:22 -0800 (PST)
Subject: Re: [PATCH v6 19/28] btrfs: wait existing extents before truncating
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-20-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2728cabc-586e-1f2e-04fb-02dc593a5791@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:53:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-20-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> When truncating a file, file buffers which have already been allocated but
> not yet written may be truncated.  Truncating these buffers could cause
> breakage of a sequential write pattern in a block group if the truncated
> blocks are for example followed by blocks allocated to another file. To
> avoid this problem, always wait for write out of all unwritten buffers
> before proceeding with the truncate execution.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
