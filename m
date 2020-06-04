Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF71EE51F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgFDNRI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 09:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgFDNRH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Jun 2020 09:17:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6529C08C5C0
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jun 2020 06:17:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so5855518qkm.12
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jun 2020 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EmTrW/KFeVH6j0RQlirEd1CmsWkJxATeLA5oX8xG4Dg=;
        b=Bpmc4oB5r6+qtw540m2lw05XwbRPHTufPthIR9q5+BZuDZ4lnOHep0syx5voirxtcf
         9ZePbFajtvwMUJhBI5QkORabFHWnKRLIft+8Q+2y1eYBhp9SFZDLL0tVHt/U9B5sXtyr
         09Q0n5DzZoKI710lEVGNsdsRi8oIV+GPlLTWW7MLSXhBTM0q1wXVd9g/W6u5xck1DxS/
         Qw84q2ICrN2vf+ovQsvau+dBp/zUPkzp6lzjB6L0zlEKTzHtaqB7EhUceZr8XMkqopTL
         b2pK317oQs7tHrmWk2fXj+5YpYsY3bhjcilzBUBb7BlUfCzoNN5mmMOe0IAzcpaA7H42
         NDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EmTrW/KFeVH6j0RQlirEd1CmsWkJxATeLA5oX8xG4Dg=;
        b=GheOvmjhFMx6v4C5H5ra47CYZ8aJO7Zxw6b7muC30f45+RW/aGpvBNF+0CgEGpfIwV
         WOlRcotdlXeKbvcRDxQCM4S1LjuPdkF1kU8x6UtcCxrj2MKnlrYZIwMkSgjTFgme8OL+
         olHnr9bnoa5HNtU/zdAtIFk5cjI8fHazaL+D4psYsXxxB08ZaXtnj6wRxakyDmStC1p/
         SGfsyfXY92kV9mbhL/+5c+l7rfhOZt/lwZu7QMq+TUAr33/8NNXPJ5FgMn5VfmsRc/fR
         nMcf6fGKXbvNZdTtjfd+OqH/xB6pG2+rpHozlxL3G2OLiFxqkrJflTvsbHJWr+GwxMCx
         UPyA==
X-Gm-Message-State: AOAM533Yd1HJYYowLn/hXe/VF6dCifLFL/1j7BiAn3F+SD+Y2bsdfspK
        yQVRUozSpReWz1zoNrZaLV52mRUiEQuVXg==
X-Google-Smtp-Source: ABdhPJwiC9kEfOiCkRwW2Mm8UNum+95B173K8xfWjPLCetA943l7a7EBIPlYHQIrk3O2WzrHOAxn0Q==
X-Received: by 2002:a37:9b05:: with SMTP id d5mr4181955qke.76.1591276626548;
        Thu, 04 Jun 2020 06:17:06 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1051? ([2620:10d:c091:480::1:c550])
        by smtp.gmail.com with ESMTPSA id f7sm4018640qkk.88.2020.06.04.06.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 06:17:05 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] btrfs: Introduce new mount option to skip block
 group items scan
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8303441a-d192-7c7c-bd22-fdce2bb894bc@toxicpanda.com>
Date:   Thu, 4 Jun 2020 09:17:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200604071807.61345-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/4/20 3:18 AM, Qu Wenruo wrote:
> [PROBLEM]
> There are some reports of corrupted fs which can't be mounted due to
> corrupted extent tree.
> 
> However under such situation, it's more likely the fs/subvolume trees
> are still fine.
> 
> For such case we normally go btrfs-restore and salvage as much as we
> can. However btrfs-restore can't list subvolumes as "btrfs subv list",
> making it harder to restore a fs.
> 
> [ENHANCEMENT]
> This patch will introduce a new mount option "rescue=skipbg" to skip
> the mount time block group scan, and use chunk info solely to populate
> fake block group cache.
> 
> The mount option has the following dependency:
> - RO mount
>    Obviously.
> 
> - No dirty log.
>    Either there is no log, or use rescue=nologreplay mount option.
> 
> - No way to remoutn RW
>    Similar to rescue=nologreplay option.
> 
> This allow kernel to accept all extent tree corruption, even when the
> whole extent tree is corrupted, and allow user to salvage data and
> subvolume info.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
