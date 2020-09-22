Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD0274509
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIVPMD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgIVPMD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 11:12:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27926C0613CF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 08:12:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so15822032qtv.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DlgOsA9MJXETo/uxC0IBj2+gEOUwEWkixtaTYbRTGCM=;
        b=fZ5XjAzf8bWdP3yx30TRPGpKfPNKW/8k6niILwcohA5Vuu+hmWLEkTmW4iDVY8NNLy
         gwTCs7ZrtCTAdu4jvUqkRo6SsOrUHT7UEB00q7LRAKyAeeTFosrI44ukBUg1xe8cHYJj
         GrTk3oMBuhxJyprBcuxzQYIFuxZy0YgFTMnqh1Zn04wpbLVO21nwBoIrgiYfRrPApB6f
         lVhyqADtqd7SH+AbrQXzPwlbDji9806Uq2q6SVPIIubXovdx8Xekt7cfgCjURfxQhAi+
         Edkgp8XxhnmPioCFl/x4ZBqTAG6R2IcgEQjpY0/941VYEYaqqb5y/WwiGigs0ICc10z5
         2KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DlgOsA9MJXETo/uxC0IBj2+gEOUwEWkixtaTYbRTGCM=;
        b=OOS1maYpB5FJr1W6K3RokIPA/Vp3DSnWKIqUK2DVCOCu9rrEKkdFOeG4H9BfEw+Fbp
         MoPCahfEMTQm65zm1nSL44xqbctlZH84JLa0YXyAlWgMS/XkDwbmBFDzO9+0PQ8tbdqA
         Xy4jCDNEXy2kkGgCHwP7/lQHfQD0Rz9KDQgXiWu8TZFUi4Sl/KUvVb4KCp523BgvPbGD
         Y2m89/Xb6Kf8urJZcOrgSVOKTClmE+YY9j2rCb0ClevT0zbMbbmci9aAo9UkV242NPIy
         V+yyIl2/1s0csGH5HPebxVY8UfYrLUHAdnYm7imNAKZWXICPwfX9YPEfqrMVVym0N/y7
         aJzg==
X-Gm-Message-State: AOAM531FKRFtcB85gjISXJQcC2J4uyqoa31CoR5uSFMNBXg/KD2f/T9e
        Bs780vgXMQFlRlUyfgVZnQkgAw==
X-Google-Smtp-Source: ABdhPJxSRskD7FJ6afCacpYFwocLXoszvJw/M/MY51u4zvVrVfgPl2WMLMsQo7rCVanv0JeSseR+oQ==
X-Received: by 2002:ac8:73c2:: with SMTP id v2mr5244437qtp.106.1600787522364;
        Tue, 22 Sep 2020 08:12:02 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z133sm11978488qka.3.2020.09.22.08.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:12:01 -0700 (PDT)
Subject: Re: [PATCH 14/15] btrfs: Revert 09745ff88d93 ("btrfs: dio iomap DSYNC
 workaround")
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-15-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bf7c11b5-db52-284f-a990-00ed76f8fc70@toxicpanda.com>
Date:   Tue, 22 Sep 2020 11:12:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-15-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> iomap_dio_complete()->generic_write_sync() is not called under i_rwsem
> anymore, revert the workaround.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
