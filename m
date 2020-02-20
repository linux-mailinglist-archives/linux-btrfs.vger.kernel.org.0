Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E33166117
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgBTPhp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:37:45 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35076 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgBTPhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:37:45 -0500
Received: by mail-qv1-f66.google.com with SMTP id u10so2075805qvi.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uqGCyJ54WTOLeVNav0EwS9CXLEYiWHu4WvEe1Nf1C7k=;
        b=Sk+8gOlJ+p6umxcVWFV1SrKd6B8Q4WADsYCM1AYv4wVVDYUSTkExvsPzmZvug2LE2F
         YiyYuPDB23ZJmWBdlkJUHzASvkdEreF/aUlSnodsHwF+Z8eZNCatGBcSnSGbDaGSKaIF
         sc0zfnAnV/w2UPMRVPJRzt6h5Znbjno5G3FazfUp2NaDRjqBV54pI+6i+1Uo8jFKAIeL
         uZ/3IOpG91W7vsPY2Q47rNSiw8QVTOn21ZxF1HPFnvX9FPnFMzhrjkyHw2RFziz/+sxN
         dx2+eTms6a/ht7J6AA6SZ2D0eSFAPk1tMfLChXNKV3cIABXXDfHSVYXaL9FbYa2tUB+e
         Iluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uqGCyJ54WTOLeVNav0EwS9CXLEYiWHu4WvEe1Nf1C7k=;
        b=n46toLW3cKNUYm4sLt4sDBP34lhfWl1H8PHRmYxf172u4UNAGRe6aidWdf0MvZUkYf
         btxgp1ANLFQcK7s9XzugP+wEZgkYpfdpCkohGan9oUF4nQ3/OxH3eURyWUWSEmhzHQqG
         hQvBReiTy/+uWGOjlkIN+9DYi/890oRcKfy/nWBds+A21L55ZJpGHWyy8SeDgLEMw6hK
         ZlMPBtpuUuPDB6AiGFChgwTQJ/dbd/G9Lp02hx9/9aV5cOuCK8A7l4FF2UFE0UFxIyv1
         GIR4SqMwkweyUC45QC3MvnT9TIL/Wzq1/aajtDo8qiZH+d7yW/Q2NdC+zG6Gm00CfPHD
         C5cw==
X-Gm-Message-State: APjAAAUpGp3tOUTgSCwN78RgtfY1jvJb+8ZsKAYUmpFZnn2/RJCX6/v2
        km/hgIFD5Car6uLBOxbflhBooZe/+5c=
X-Google-Smtp-Source: APXvYqxePxVvV8TqMpmwaIFVNtuaJeG2c5b4tPzMTibbJB/N4bAmiJHuPIShm80drRgeNRExsbiZzQ==
X-Received: by 2002:a0c:fec3:: with SMTP id z3mr25293982qvs.111.1582213063857;
        Thu, 20 Feb 2020 07:37:43 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k4sm1858878qtj.74.2020.02.20.07.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:37:43 -0800 (PST)
Subject: Re: [PATCH 3/3] btrfs: Make btrfs_check_uuid_tree private to
 disk-io.c
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200218145609.13427-1-nborisov@suse.com>
 <20200218145609.13427-4-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <496bf70d-fcce-adc4-8d5f-f902ff7cebef@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:37:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218145609.13427-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/20 9:56 AM, Nikolay Borisov wrote:
> It's used only during fs mount as such it can be made private to
> disk-io.c file. Also use the occassion to move btrfs_uuid_rescan_kthread
> as btrfs_check_uuid_tree is its sole caller. No functional changes.
> ---

Forgot your signed-off-by here as well.  And it's "occasion".

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
