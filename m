Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6642D13713D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgAJP3x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 10:29:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40328 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgAJP3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 10:29:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id c17so2159699qkg.7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 07:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hjPfbmbqjc68HyaoM01ejlaOsYWpxKkvIsWkRZ7ZDB4=;
        b=h0C3NCKf77tbSFB41GTkhjlcZudNck+l6UycXTble9k4KG5DPu+ievFAFrQQ2RIkpB
         9gfkm2DCwPpQgTSUvW6OrU7Iiv0+3rrCZHxdmXIfEO2xabju2Vcdyf2EMMGYmSxMy2g6
         c1bdQai6Y04Kh71yQ51L12NsYAxcx/+hbOxdf3axaZ6T2OMTLv+eVAutZbzTvXJmUbiz
         0576t4aiB9JcJc4GL6u5Zbf0JRrojHVvTNXp/rq9a8N7lIfGf49gborWgm0MDEG/TXZ2
         FcL+ate3LSIFAxjKNxILXSR00YXCh1sRhBDjfcNaWzgbTRWYNVaj5BnYRILNz7Rl0ah6
         G+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hjPfbmbqjc68HyaoM01ejlaOsYWpxKkvIsWkRZ7ZDB4=;
        b=ZF8Rt1mmO8i9o7aQLdCvoyEMn3zXHJnZ4S1y2jvU3CS5pQr+zAa0NqRU/7DlJtSgfG
         x57kOm0peUqTvWx16Aagw7ml6B4zPwt+Mcs0icCZm9IaVmE5VZPZ+4Y2nHaCZE3QWZHb
         3g2PT9DINp6iJqXR5nvmuCoq7/iVv8pOxNtJfWMqvTX9Xm3kG5dsm679/9OF3UpH/8SQ
         +xyDlPkvCnisJJln/HdC5dcg+ODBNn0VFga5aiA8PfBFuaTuQo82bLG1TQRKUd4UkpM6
         ashpLYTHGXKM9MiJ+AKxaD7QRmwcZA5JfAP/78zEifQXhQAaRnPAP8Ty5GSZ/fUbSDSI
         mb1w==
X-Gm-Message-State: APjAAAWnV4FUEYALaT2XNFVa2vRFJXhmE7ImK5gFs/2WPv5a7WoLJLmf
        FpBLmMe3VNJkH27xWQFe1K7KcTIVtVv55g==
X-Google-Smtp-Source: APXvYqz2msHvp7PR9xsdtutTbLTiVCXf0FRgEj8q6yjPWB84eUjOOI3pNi+rAZzZi5MVVjDtlVcBvA==
X-Received: by 2002:a37:a98e:: with SMTP id s136mr3724273qke.253.1578670192268;
        Fri, 10 Jan 2020 07:29:52 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4dc2])
        by smtp.gmail.com with ESMTPSA id w29sm1170947qtc.72.2020.01.10.07.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 07:29:51 -0800 (PST)
Subject: Re: [PATCH 3/4] btrfs: Handle another split brain scenario with
 metadata uuid feature
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200110121135.7386-1-nborisov@suse.com>
 <20200110121135.7386-4-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cca95582-59e6-d639-e1ca-bc6533374522@toxicpanda.com>
Date:   Fri, 10 Jan 2020 10:29:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110121135.7386-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/10/20 7:11 AM, Nikolay Borisov wrote:
> There is one more cases which isn't handled by the original metadata
> uuid work. Namely, when a filesystem has METADATA_UUID incompat bit and
> the user decides to change the FSID to the original one e.g. have
> metadata_uuid and fsid match. In case of power failure while this
> operation is in progress we could end up in a situation where some of
> the disks have the incompat bit removed and the other half have both
> METADATA_UUID_INCOMPAT and FSID_CHANGING_IN_PROGRESS flags.
> 
> This patch handles the case where a disk that has successfully changed
> its FSID such that it equals METADATA_UUID is scanned first.
> Subsequently when a disk with both
> METADATA_UUID_INCOMPAT/FSID_CHANGING_IN_PROGRESS flags is scanned
> find_fsid_changed won't be able to find an appropriate btrfs_fs_devices.
> This is done by extending find_fsid_changed to correctly find
> btrfs_fs_devices whose metadata_uuid/fsid are the same and they match
> the metadata_uuid of the currently scanned device.
> 
> Fixes: cc5de4e70256 ("btrfs: Handle final split-brain possibility during fsid change")
> Reported-by: Su Yue <Damenly_Su@gmx.com>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
