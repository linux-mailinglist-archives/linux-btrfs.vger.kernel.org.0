Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D7298EE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780348AbgJZONu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 10:13:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775688AbgJZONu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 10:13:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id 140so8394931qko.2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AHD0EgLMEZ3cWee+hmXMKd+mADKvmQVP5Kg90zwNJII=;
        b=tuyoSaTrr8ldxE2fZo0sx9Lf4nksbSr1/edRxPq4vW1MgqovjuzBwdWk6fsN3faz5q
         KES6exUVtET26ZGVMee0PnlTXt6mzQ2nPtQHmrsD9y1H/a2ESpuzPmndSOpAzwAtF84x
         memZSCYzN5sq88kvEdVhckZvnvFm/Tn/Wno3E+/Y0XyPcKgy0FrSDAzolr3PdkD96agl
         VZw8b8nf9DFmowle4wbn8ImQLwDPDjUZ70FqP54rIp5Ow+JoxzurBgCzt78xLR7K+BC8
         zeoNchttsRNh8mbTWUIEb7x4Ohfhr+3hZiGyF6abCYy5lgFg+kLXmpRVgWcMRIv9mxuM
         2cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHD0EgLMEZ3cWee+hmXMKd+mADKvmQVP5Kg90zwNJII=;
        b=iw+rajfretPnBjb/NyfzajM4mR0iB9JYs/oEdmospNCTxotOuNHYoR5e9C40gVRzHH
         CIhNtYaQB5svwusellNUWM1n3MwItp9gpdpj/prxsufjGO6X5vGXKrU3/9/Fe/gMnjEt
         MR7rEG06yOi08ihF8hvuENmj8e1Iu4lXf6I4z8HdB5bohvn5fLTK+pJEjk2ewk2jN+sA
         XWaVNAq+uZMxH5GfQX208+AT2LGGWI9bZuzAe2tKAoe5f16Fnw4znJqP1fKEB7GVaeR/
         ZquM0bcH69JIjjdCLbVLwkbaHMltvq7ae513suZB08IbpQsUdkL8SWYMQdcPtATGyKvu
         +EtQ==
X-Gm-Message-State: AOAM532NQiRuanXt0WgBDpKUiTcoKPPju3ifVy9JJ9pu+lkbJTLnhe5F
        0NZCH7PpwxaeayYE5IYnDTcvJ6MCrUK4rPBp
X-Google-Smtp-Source: ABdhPJw3UAqdyXGVqwxKtlXa1kY+qicEJLS0w4g2kgcd1r6VBYRR5jd7V4bYGtXffrnbakcxbbZDsw==
X-Received: by 2002:a37:9b8b:: with SMTP id d133mr18015205qke.486.1603721627210;
        Mon, 26 Oct 2020 07:13:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g9sm6722661qti.86.2020.10.26.07.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:13:46 -0700 (PDT)
Subject: Re: [PATCH 1/8] btrfs: scrub: distinguish scrub_page from regular
 page
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201026071115.57225-1-wqu@suse.com>
 <20201026071115.57225-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <76251207-919d-82e6-4bae-cc6829be2961@toxicpanda.com>
Date:   Mon, 26 Oct 2020 10:13:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026071115.57225-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/26/20 3:11 AM, Qu Wenruo wrote:
> There are several call sites where we declare something like
> "struct scrub_page *page".
> 
> This is just asking for troubles when read the code, as we also have
> scrub_page::page member.
> 
> To avoid confusion, use "spage" for scrub_page strcture pointers.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
