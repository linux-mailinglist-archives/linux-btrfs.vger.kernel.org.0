Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909644409CB
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhJ3PFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 11:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhJ3PFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 11:05:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FAFC061570
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 08:02:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u21so27004547lff.8
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=h84v5gj9sxC2T/V3PtPQ8tdSmpnyez0cbL6+HSUxKzA=;
        b=nSNQ6UFzSNVzyTEbeO/71ijEY13nrFxq1+sx5y5qaIUGHkSIJOdP5x2vQz1C8l66Dt
         rNzkR4qou2DkWkzPpOCsPGfN3Z/HLuaTQuS9hxaleRQ1F0zc+ZPTulMREiG6GWvKmjma
         oprHKnS+qFttbgUYP21UxFXGRJAPqJSzAx0Unp6YOaD6iMEIdtDsZNT04bZns0U96YhL
         hOoqvsX+9Z9N4XECxw7EWJgFXkWonKs+7MvOhCaVvDnB5ghNs31lH0+x9bp+NIq4KSTt
         ErolY80pE++9kEqqcOqJq9O3WPW8l9qcGeiQxR/oDwUWuOdQjeQ19AkUgwpnWiRzX6TF
         xk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h84v5gj9sxC2T/V3PtPQ8tdSmpnyez0cbL6+HSUxKzA=;
        b=fWa3LLwOMYjOaBL9Tcn/qgGYwnf+1+gapnQzwTQRm5qn+ZL24Mm7CkfGkuLiHIqBKx
         TpjdG60s3Ctbi4WFR6qH/50EBxUuqBVd9eudRi6i/nCAzchqYg50SlJuzi1a/muzZQP0
         2qrplwMcfyVJaBCL5+L2OCXDtpfE3fy9N8Blt2tlc6vHrda/7JKS/URyK+FaKz4zHJ7U
         a1CHfnsQarOn4Ym2TMHzcsMd3liB816G2nV/M/HLuMOshAVfBc/9s5e06LpztDWaO6A/
         HiSln8YDR/p0seaoZ+HSpfcNOj7yodet13e5hLrWN20GBeTRaiFt3M9+5MiSjLEbVwau
         7jLA==
X-Gm-Message-State: AOAM530pMmb9SbtlW4I7KimiIEyZmyhO0A7rMOJRRx/ceA0TJFxRcxC1
        UHum9PHUGp2PT6BqrMdZyvsTsD9SZnA=
X-Google-Smtp-Source: ABdhPJwLqd/MY3kV0aZ4N2dkflhf2zNoZ2wpyJi5Qg5pgnl+u2EuUbSbyjw/I0xXCpPya2AJkZb/oQ==
X-Received: by 2002:a05:6512:261f:: with SMTP id bt31mr16999452lfb.506.1635606164833;
        Sat, 30 Oct 2021 08:02:44 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:2ee3:d0da:16e0:4d67:a3d0? ([2a00:1370:812d:2ee3:d0da:16e0:4d67:a3d0])
        by smtp.gmail.com with ESMTPSA id q6sm937750ljh.1.2021.10.30.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 08:02:44 -0700 (PDT)
Subject: Re: Btrfs failing to make incremental backups
To:     David Sardari <d@duxsco.de>, linux-btrfs@vger.kernel.org
References: <58d81c70b2c7de2faa209b56ba18143b5bfb6e2a.camel@duxsco.de>
 <3574af93-d40d-1502-3c8b-5c71c2ee1abd@gmail.com>
 <8d2d6b96071b9f50c2a509c71a0eb34fd20b4349.camel@duxsco.de>
 <9eefd0b24436350452e993dce3cf02c4f6284b71.camel@duxsco.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <d73a72b5-7b53-4ff3-f9b7-1a098868b967@gmail.com>
Date:   Sat, 30 Oct 2021 18:02:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9eefd0b24436350452e993dce3cf02c4f6284b71.camel@duxsco.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.10.2021 17:20, David Sardari wrote:
> Here is what the corresponding parent snapshot looks like on the
> destination side:
> 

Please understand that mailing list is not a web forum where you can
scroll up and see previous posts. You previous mail may not be available
when reading so context is lost.

> bash-5.1# btrfs subvolume show "${DST}/@2021-10-30-095620_files"

I asked you to show this information for all snapshots that you have
listed on github for a reason. You so far only provided two source
snapshots and one received snapshot.

Anyway, your two source snapshots show the same received UUID which
confirms what I suspected. It means that every snapshot on destination
will have the same received UUID as well and "btrfs receive" will use
the wrong snapshot as base to apply change stream.

The same problem was discussed just recently and pops up with
regrettable frequency.

https://lore.kernel.org/linux-btrfs/CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com/


> WARNING: the subvolume is read-write and has received_uuid set,
> 	 don't use it for incremental send. Please see section
> 	 'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
> 	 further information.
> @00_snapshot_hourly/@2021-10-30-095620_files
> 	Name: 			@2021-10-30-095620_files
> 	UUID: 			59c8e5fb-f3f7-d448-9da9-e2af0cc5b0d8
> 	Parent UUID: 		e04d86db-293a-cc44-a226-059677aa6e11
> 	Received UUID: 		7eb8ade9-0234-474c-b3c6-
> 3b439bb51aa4
> 	Creation time: 		2021-10-30 11:56:27 +0200
> 	Subvolume ID: 		3275
> 	Generation: 		1048
> 	Gen at creation: 	1045
> 	Parent ID: 		1988
> 	Top level ID: 		1988
> 	Flags: 			readonly
> 	Send transid: 		319434
> 	Send time: 		2021-10-30 11:56:27 +0200
> 	Receive transid: 	1046
> 	Receive time: 		2021-10-30 11:56:27 +0200
> 	Snapshot(s):
> 

