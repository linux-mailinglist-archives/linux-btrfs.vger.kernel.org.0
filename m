Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38A253171
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHZOgL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgHZOf0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:35:26 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9700DC061756
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:35:25 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x7so790308qvi.5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dUmlD/RPvzzVNXRXOmRKzAwj1iBGewNaJ4utwTv20ME=;
        b=yr8bMwtqah/WRrcjIP1jJIgwI3Jtt2AmQLpf9H2eqgVUJo6kesX1kvsWV8ku8bVmeL
         xS8O/4B0DJFX+/U+QEocJwlGVRFCMvB9tH8lvYAFevwD/h+srMI8Tj3QbF9pzYaLMWJh
         c36F3Z1enHdyeERmI0FgOZGJAMUxCndl4+e9hEFddO4rVYuGx4plk+bTafsEyQr02HWl
         BHoG1NN4xlWjtuGyuf/FDFgQGuEoR5+/2N+wCUFyKp+89z2pGj4MI1bztL0jXt8ziawX
         yIpBuCTNjupDREC7YvC2ymWH+lxhQ9twG6Fky01Ryt302sUfD8Hm95WpXlgvD5AjmBrl
         BL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dUmlD/RPvzzVNXRXOmRKzAwj1iBGewNaJ4utwTv20ME=;
        b=T/xTpBhCCSqdtFLD13dkdVaOzY89xOHu1Rnal+7P5qKcZc/lzAmH4AVBpRsqMCKkA0
         RyTCnaHVZ8YTUYsj5WSlNMQCHZnHK4tknnraUOdBo2kJv0Kz0PbHrEhIBpFZxcJiJSuO
         Jws+ukbK8nbC0m8jh30BLQNcN/TLCU0AQ8zpugP3noUW9yBDPpVwEeBTQOv3NrO5YWdv
         t6QlRYdwQaO/YIVPZvXYgaY8PVOPwoZOhUUtTxws4yBwPnB9Pxotjia4h+yWVlzAB+iI
         lc6xM2nQMWQA0D57p7Pl29M8bptC01ybxzudYnxYL7LSGfw+PfKuEd7Mi72n3uYUQblF
         6PEA==
X-Gm-Message-State: AOAM5320A+2fEEjVZwY231zHOsoNJ+s9+Yhyt5r4f+BvyJyTXMm7HvUk
        AhHo4tvNzK2mqQdm9mUHh9bMg+t8KoaJlpBO
X-Google-Smtp-Source: ABdhPJxLRKlYDjBhSVJkN5BkxGu6stqExVf95W3+Nn4Cmv2InhN/ryOTQmL7scDQ8ifnmNt8Tvwu+A==
X-Received: by 2002:a0c:fa85:: with SMTP id o5mr14333439qvn.91.1598452524557;
        Wed, 26 Aug 2020 07:35:24 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10f3? ([2620:10d:c091:480::1:efc3])
        by smtp.gmail.com with ESMTPSA id v28sm2297157qtk.28.2020.08.26.07.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:35:24 -0700 (PDT)
Subject: Re: [PATCH 3/3] btrfs-progs: tests/fsck: add test image for inode
 transid repair
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200826005233.90063-1-wqu@suse.com>
 <20200826005233.90063-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <37552722-60c1-1a2a-ab24-f9ff257a2693@toxicpanda.com>
Date:   Wed, 26 Aug 2020 10:35:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826005233.90063-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/20 8:52 PM, Qu Wenruo wrote:
> The image would contain an inode with invalid transid:
> 
>          item 4 key (257 INODE_ITEM 0) itemoff 15881 itemsize 160
>                  generation 6 transid 134217734 size 131072 nbytes 131072
>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
