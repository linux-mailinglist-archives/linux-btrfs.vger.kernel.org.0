Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3783018201F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgCKR6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:58:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46457 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbgCKR6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id f28so2930794qkk.13
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0I2cP+M7dvP9KLF2IYwbOP6q1/QJVzFoNFV323wrPZI=;
        b=fYnfNso9lOnQuYc6+oulu1OBVXxByPQSarQetihw5tMn5WTwUNN4bcJpHeFVFLia9x
         0/F0trwTLmvhrm1gNL4GlezdTI2VpZDZcshiCwqnLx1bQFhyBT6C7j0pke8LFqy334pv
         GxC5FUMed9q5tP6NcHmwyO7hRxGAP8VdTP/X683U+hBfUs33Jdgesad7Ust8ww0YXSUp
         IXN/s+rxw+DMVfGKvYg/nVOsBwJossqoOXUlZlwksG2O+NtQMHW67qJG3qUvG1vel1Kp
         CO3pEzqG6hYDhP7G7RhAy1rG+VjHiHoXuXgoiPUgmjgSZERAY8f1yIXO/mJOszU5sJ77
         J77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0I2cP+M7dvP9KLF2IYwbOP6q1/QJVzFoNFV323wrPZI=;
        b=q0osrTgtwP4bAzmFApvUquFe4smLJ9z3OpQxI/e49dJ/Db5FPAykC//ogyYCTA5hiJ
         7TMg4DIFRjigKr7BQV+BkAxrzHPmsCTapfITT0HL83qboMSMdVdhNa1dI+mGvA8+o6LU
         /A4/7uPHVXC4uz4z8pK99xZnvROA/DQdH0HSSBLxumNyzQtnsLQL+l3Iv0uwNztt9x/7
         f9XWdbDy6O1aeYYraeQne7r6Q21QcLmDY7NH2kFyuoNAz3i0qeRO/8vSMQQB7XB81byo
         YBRLZJ9vzn7VMw5GtqL8ZpIv3lEJR5X1Gy2lD2SXSbepekxWn+SPlXWuGEhjsfp/DaRs
         QOuA==
X-Gm-Message-State: ANhLgQ0P7EcG/nReF8VKcELkCPKdBAYY+FQ1DU2sQuSiLAVlPLNxn8Mm
        L8ZPa54fbdMEWVr1S3Ss55UFzqU3VUM=
X-Google-Smtp-Source: ADFU+vvL9BNxU5D0+1d9ccTHdp7WAcaUdfMypV887icsiXDQ3MyRwX7i3Xky3WldGU4eeHGmq4tIkg==
X-Received: by 2002:a37:5f07:: with SMTP id t7mr3787777qkb.159.1583949498461;
        Wed, 11 Mar 2020 10:58:18 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 3sm26683512qte.59.2020.03.11.10.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:58:17 -0700 (PDT)
Subject: Re: [PATCH 07/15] btrfs: make btrfs_check_repairable() static
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <1ba159f3930fca7d11350f798ba140e1a2176358.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a12a09cb-fd29-64bf-7930-2f534e84db2f@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:58:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1ba159f3930fca7d11350f798ba140e1a2176358.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Since its introduction in commit 2fe6303e7cd0 ("Btrfs: split
> bio_readpage_error into several functions"), btrfs_check_repairable()
> has only been used from extent_io.c where it is defined.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
