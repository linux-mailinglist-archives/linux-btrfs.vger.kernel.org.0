Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEE027B412
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI1SHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1SHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:07:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056FC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:07:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d20so1839159qka.5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jgHFBms6DPh5zjdv6B3gqZoyjcePvB/Mtnx7CMuUa5s=;
        b=VxJqoBgINEksD0qFfOH0+Wh7iCGuw94vWL7Q66OClOJHzNkgRgotsVNt75pTJMlW/l
         urLceiSCRmbcIjVbfRkVNvHo3fr8hq7ZURbiVch8B4nIZGXnFaaWubxqITLnUSGIDym7
         7KBdmtWUn8lSVclg5Fx44fH28cuhaY4/dfOiaAnypEmP+ncxQ0VU154EBl3ynw57w39H
         nXjgxulggCrk1iCk2/8DHkY4+nPIqzgnDDqznfDl1d/jnFjQfgVavHsv001j5/aAeLKQ
         MQ1UqdgRPR02EQk/6fUhDL/VG6QEwhULSQFK/LaYOyhNyyJz8+bYnc+Ald2ud8B3PTdt
         xPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jgHFBms6DPh5zjdv6B3gqZoyjcePvB/Mtnx7CMuUa5s=;
        b=As9JzkX5c3KgIIAU6QYy9lAquo0th12+o6zaEAqfl21MhTvyYr2y6rB7lymk1a2Fh1
         wOUnE/sOuNb/3tCkDCSIxgwyA0pLOMci9ohGLdQT+9pO+W14tnHLAGC6Jbe5zzCz85cU
         fjRlqejyVF/VGsCafkCe9+PMl5h7UoBxDTaWkmlBt3E56eruki3u9+kvCPm4iX+GmK+i
         VMN4MdKWyAQfk+47i3BxVAteTbngwQFex4HnEHILWFPuuNPEn60bEM4uBOx9AvnizfF5
         XnBowiGT0rS48Pm5KCRI9f8xBqxspjdLltWjMm9PpPl7GpML3E8Nrv+U4XBkrE3zkhFD
         u91A==
X-Gm-Message-State: AOAM533iNFi8y0RjAh15qWhHqtBOG/C/fa+hgfL4xT8LVbqmKGL7R3q4
        wuiTuWh6cwtxvSDfIhOsZsXtlFLwSZbUGVzP
X-Google-Smtp-Source: ABdhPJzBdF4yajS6ajc3y7NFRnNdgVBgFtSh2WqfZyLl2BmOaDOsioBlYl6vj5ngWxbahn+CJtQwUw==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr660248qkk.191.1601316431336;
        Mon, 28 Sep 2020 11:07:11 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b13sm1744310qkl.46.2020.09.28.11.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 11:07:10 -0700 (PDT)
Subject: Re: [PATCH] btrfs: use iosize while reading compressed pages
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
References: <20200915154140.mlmlwmctre2prf2s@fiona>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <64af8422-218c-718f-9375-1f1a9dc89acf@toxicpanda.com>
Date:   Mon, 28 Sep 2020 14:07:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200915154140.mlmlwmctre2prf2s@fiona>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/20 11:41 AM, Goldwyn Rodrigues wrote:
> While using compression, a submitted bio is mapped with a compressed bio
> which performs the read from disk, decompresses and returns uncompressed
> data to original bio. The original bio must reflect the uncompressed
> size (iosize) of the I/O to be performed, or else the page just gets the
> decompressed I/O length of data (disk_io_size). The compressed bio
> checks the extent map and get the correct length while performing the
> I/O from disk.
> 
> This came up in subpage work when only compressed length of the original
> bio was filled in the page. This worked correctly for pagesize ==
> sectorsize because both compressed and uncompressed data are at pagesize
> boundaries, and would end up filling the requested page.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
