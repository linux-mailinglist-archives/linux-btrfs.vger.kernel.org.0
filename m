Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A03623A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbhDPPQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245644AbhDPPPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:15:34 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E5C06138A
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:14:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e13so19324630qkl.6
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1bJFcbEN3d/hksQHUcs82srGpUMysxnluoGV7OeyCMg=;
        b=Cuc/kT0mXslUykHR5zlUDWa3iq7rS3kv9IM0ob7fm3VFj9Uch1Bm9xWC/wm1ZZDlqx
         Ffy3IfvOItp38AWWn+3svGuhwqLjxnbBAYb6zicmUhXV1kMif+NRdXrLz9sEUsApyg8R
         r8bcxlteDt2dp1bkfgMpUAfOm2GTAQvtOWazf16L4Z/etAZOEFLj/leSuJ7j9Bagx/Py
         tv2sGrN2ps+Zb+846TC7Cmpu/02zxHmAa8jjzAhsZ1GGZwbCeLzzSj4PD2bSrQP5tEMw
         vNZ/B4hYH1hs+tggvkCnq4sa/UfE/FOuB9K1LEuazxsJoxABn90Pz7sOsiA3VkiTSqyn
         bzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1bJFcbEN3d/hksQHUcs82srGpUMysxnluoGV7OeyCMg=;
        b=Qc8JPNrxp2LhgC14sY3A5ngI0HTH30XM7VzC0IeQTAeMOZCyy820MgXLSEfqJ/A52z
         xyKGC6imLgxocAKE7jOEPBzd9UYelZttVnyY7/5xDjCDQ2HzkeHP2nvKtytKoWlsIvaC
         m5dYxSD8YWLvriRarXty2JQH7BiKRqHSjz4YVCRpFlZKw4cHiw/zn32q6uBFRpvBEY1Z
         6yQ0cJ7UJZMgaPOxPWpIDsulDnSzoP5g3W754Qi/Bo2A6ZW9aos7AbeN2DNuX9Ao0GOR
         FhdIQ9XaBFTOJpS0qd7HLmBjoEhmbclD/IrfuRmDazUuTFbPVe+dVRcHMweoabNlP8SJ
         ysuA==
X-Gm-Message-State: AOAM533jKCcFcEh29gxLDa22eDYaEYIA91n2d7EJVKD2IcEoje9r9XOk
        NcjdeiVDKi0beye8pl4ADU1tMJYAkiL4lg==
X-Google-Smtp-Source: ABdhPJyRUtwOnJrHgXtAs7u9AfRcVH22e0EJ1kMBZ1NObNYN5ZVjzAK8khMdY0LTnjdsLR814F3ojw==
X-Received: by 2002:a37:2c41:: with SMTP id s62mr9424239qkh.205.1618586086730;
        Fri, 16 Apr 2021 08:14:46 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f2sm1136226qkh.76.2021.04.16.08.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:14:45 -0700 (PDT)
Subject: Re: [PATCH 18/42] btrfs: make btrfs_dirty_pages() to be subpage
 compatible
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-19-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <710c4016-f5fb-e786-ca75-cf916eace7e1@toxicpanda.com>
Date:   Fri, 16 Apr 2021 11:14:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-19-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Since the extent io tree operations in btrfs_dirty_pages() are already
> subpage compatible, we only need to make the page status update to use
> subpage helpers.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
