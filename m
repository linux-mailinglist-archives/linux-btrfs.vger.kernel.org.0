Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429DC145CDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAVUGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:06:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40247 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAVUGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:06:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so1011867qkg.7
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oWEfSt+cxAc4/eL1RjGjo8qx1BunYEQPGpwosztAK4Y=;
        b=OrWCcq2+ekYyrvWVDFBQY8Sh3HhOdwQVw5RGKY4pjljMiBZpar36HfKfEgFFyCRnxr
         aCc8f6Szupvz4WBm2KKA4v2bNSTHIH7fXlyplpMffF1MUnl7T59oLMzZDO/o7D+kpBI7
         TFbI510Fp0RisfN1I1VjD5MMwZASoCg5/EAcHbyFLdhoKU92zTgSFuiLixjYnYOrwfRT
         UY7mhxNxExGUY3GxZSEqYZ1r4P5xk070DxFEtmsZtHVMTaM8zwSnHwdXloIcaHe6hzyy
         n4NhlKVrgfNibrsV0MU/kCIPOGSV4rDznUtW0Ppd0mFhAvd5wNag4SlQzeklxh3FWXpc
         P9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWEfSt+cxAc4/eL1RjGjo8qx1BunYEQPGpwosztAK4Y=;
        b=dZ0raqtdUbIQIPbtEloF5ISzhH72zYeOrl1reAc0sMHEHOuPsqFfJNWQFq/jMBeo8w
         zoTEkG+kcC5UiH7gg9+Rivv4NGwRDbmtjON47jfQrgxbyBeQ6/t9Y+Swka8eDFoV9aNJ
         izIfIRhTec8I2MlQMTxuOZZSzhtgqrdaEVwxVTUd397TFdLOXU4dfU7ELvfk3U7MrRSv
         zP5CgFIJhW3WIieAzX0cIyFX3Kh2/PBHnkSmOTzAgRiDn6FvOVCWhDxl5sM9fKsxcpDo
         EYFXgifcAmizG01/HCwPCYY/l07BFPcGlK1OL5sqW6tLcwq1XKhQxWlUzwj4Fw4BECfg
         ZQdA==
X-Gm-Message-State: APjAAAVvLlTY+/VUdjSYRkp4E0Ukbft/0SgpO+8mbuakRNB7Dx8vNxp7
        ZmqawRQDTauhG+roS9u+OpIgB50HZksZ9A==
X-Google-Smtp-Source: APXvYqyjcWEdc13Ksv/M1FYxfXdEsGNVs+sUiRQEYJKH5yUHev0yqnoVFRnijHE0B5jIKuarYPMQcA==
X-Received: by 2002:a37:a9d1:: with SMTP id s200mr12230871qke.110.1579723598492;
        Wed, 22 Jan 2020 12:06:38 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id i13sm16795qtr.40.2020.01.22.12.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:06:37 -0800 (PST)
Subject: Re: [PATCH 06/11] btrfs: Make btrfs_pin_extent_for_log_replay take
 transaction handle
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-7-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5f4fe01e-e01e-d595-ff9e-1948ecdf5ac5@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:06:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-7-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> Preparation for refactoring pinned extents tracking.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
