Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D448274507
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgIVPLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 11:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgIVPLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 11:11:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71BC0613CF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 08:11:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q63so19324303qkf.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dXYGtUykxYua6mvPMMYRtMiaiT/j3FaTy7OsDWCQko4=;
        b=NzOS1GDcGIBOafTVq7jsGdRn/HOO83BrEJjpfkHYvw+p5C3x9vvzX7rhlLxkJTjLFB
         xgupRo7oX8NGSVLKYIY5piC2Pd62pz54LICDTUXP/GXVPt6qziqR1Cci6eUh5T3k3ysf
         1KKf1TkJN7PisHRCQsZyky21JGYsvPBMIzByVy6qCxsr1M/fPYLnaVRjpRzfcpXS1iAw
         F6qA0c4F1yCDuoVTLbZxLcqpcwE55CHaEtBLGfJOe7B8M7R6jM/T/7sD19+z8cv8O+op
         jn3fOKPFS0sbsW3C+XJI44MXIbgPUei1JlVUFuImY/idiL2iZb1qJMOaiF/PdeOYD2ew
         rvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dXYGtUykxYua6mvPMMYRtMiaiT/j3FaTy7OsDWCQko4=;
        b=mVgJTM/VS2bcqK0eEmnI3/tG53I5PUO97ZBf3h7ZCzuNNzig4bn0odu/TS7huixRuL
         ECkEIjr5RDotTHPgG7CAAuIMXPNRobjBP1OxacjJg9hYC90OoElRr4vWh7Q4yXOqrZ5/
         +sxkukfp9nDoyIAV6gBVWtUqsfT2tRAWi6xw7SBBSsIq0WvyNlJjHKEQah+uBrA1QwfW
         ywnmO3WWTGaKNQa4GIjTxAjoA8gHe0BNYECpZnWMK9pUpCJ/WeJ+OiqAfzE/tgieIB52
         UWaAJXUhHMIJ7RXZO3cuNsKYD4hoGqvGE6HtFRtSG5k57/O0aHkDKpHaegDLE8l2cwdv
         duvg==
X-Gm-Message-State: AOAM532/HNBfk610rnfvA+bfoIG0sOyXe8Q6Jyju4OCytNaahRUjz13j
        00PEw9CGQnzRSHU6n6Jli4gw8g==
X-Google-Smtp-Source: ABdhPJw4FLFgXqKspThoHtIt5Gf6plVGcUb7Ih7aIMWzIXpHcenBEE2NHjSi44LTw0Zn0FZ1w//z5Q==
X-Received: by 2002:a05:620a:13a5:: with SMTP id m5mr5372182qki.280.1600787498888;
        Tue, 22 Sep 2020 08:11:38 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z133sm11977780qka.3.2020.09.22.08.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:11:38 -0700 (PDT)
Subject: Re: [PATCH 13/15] btrfs: Call iomap_dio_complete() without inode_lock
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-14-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8767fa4b-7c29-eeea-94d8-35bc1492718e@toxicpanda.com>
Date:   Tue, 22 Sep 2020 11:11:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-14-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> If direct writes are called with O_DIRECT | O_DSYNC, it will result in a
> deadlock because iomap_dio_rw() is called under i_rwsem which calls
> iomap_dio_complete()
>    generic_write_sync()
>      btrfs_sync_file().
> 
> btrfs_sync_file() requires i_rwsem, so call __iomap_dio_rw() with the
> i_rwsem locked, and call iomap_dio_complete() after unlocking i_rwsem.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
