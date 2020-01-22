Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075E8145CD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgAVUEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:04:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43257 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:04:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id j20so982799qka.10
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FVMhGCt+Sg/Kqxsw3LxH1h2SZg6PdiYMyHge9+43rr8=;
        b=dr6SNkH74gkSoTs4zlbx/2efaEINLQyuxUbTtsxiiDrJ7pm08psAAhCNCib4mf8rrn
         iSyqtDaELCB6qSs4X8RmYWo9MvnwFWsDcBKwU7W2pvack25N6F9JzbP6ZvZZ5fbZFVsi
         nJd3cjzU7Kaa2w8bLusc2w494s0PPT/c5GPPdM3DCWZ2mHCRkceP26LTACkaRbqpxRcV
         1fWJ+Gzm6iEpzUcQst91IeZU9FlUfWRsk65fiolKkU+LHDkGz5c4opL3jNbsqbpHaBAs
         aWSovLhvsQQ2jKAnizjl2TSJ7zmWdr2xjUiRlZtRwEPYkzZsEWaLszEp3N1aNFUj1CDn
         jQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVMhGCt+Sg/Kqxsw3LxH1h2SZg6PdiYMyHge9+43rr8=;
        b=FLptmFyiG6ubqj88S7IB6zlVjvuQ5htQQJu20yw//cXSIO0eaRa7ZDHmZ5m4BFnp9f
         msiKSP8B43+1sutgFUAt/L6HGEuux2gwMzBVdex7bUuKz9rq1CWmE79DjGLO+Z076RA/
         F5aXCL2fC//9AnImbPLH2TB5VeQj6/IVUgDIba06aI2lDuFPV2uN4Nm5TY/ID+QMfih8
         l0Z2wSnkCdh8DUDPaA1M+UjJqxUkxPX5xc1zGPgmshqdJV3kM29216ty1sjMSmetkJUd
         0vTK8XNiHXMdGKaU/MVeViHOuGZiNiaBuaTplLKgqNq7elg8rB2dAD/unoRoF39aN8DP
         Gpng==
X-Gm-Message-State: APjAAAV266wZp/3tOy64Qe5SCwxTasilBGSHf9q8XfQEdtbCFHqHpGag
        WU/3wCwoTVZF2XZarmqTBYmtGegRjmsYrQ==
X-Google-Smtp-Source: APXvYqw1Hx9CfOSnlhMM7I4sp6pmIVQpWn0MflIB9ftFc0J7En9SL2VwyHmaSt55ueXTBYWElCJ6VQ==
X-Received: by 2002:a37:4a0d:: with SMTP id x13mr12308914qka.332.1579723461917;
        Wed, 22 Jan 2020 12:04:21 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id r6sm21025455qtm.63.2020.01.22.12.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:04:21 -0800 (PST)
Subject: Re: [PATCH 03/11] btrfs: Introduce unaccount_log_buffer
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-4-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dd255624-ebd9-b683-6e5c-016831b0d37b@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:04:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> This function correctly adjusts the reserved bytes occupied by a
> log tree extent buffer. It will be used instead of calling
> btrfs_pin_reserved_extent.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
