Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE54A143F66
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 15:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAUOXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 09:23:23 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42150 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUOXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 09:23:23 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so1489890qvb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 06:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rlwWVbQiVcz3Kh7NQqEYC+alrKhP9bgzfLkUvy6Bzck=;
        b=zO4s5YSuIpT45d5P5r5z8hdZfVewXxpxA/KnDnJ4UGFJ88fMBQ1rDXd2aibvVACC5a
         Cq+ZX+dFW7ANKVWG64R/M0KLFEg+L3/tZX5ocl2TgtV4aC8qJnOhCiG6tciER2SztNPs
         3lzwpV6xDq8Otd5a75mI6uPavqHJngaKWUHJNwlJMy+1CuDHbQe8diW4f0Ki3HdFYI4w
         jdbJPWP/Fj+g/MBeJd1BNWHe06NGgZK/TiBM2JsFxXFvVDb6wn7pYA26T7GO+GUSLnlu
         9Qgu3ojS/Wq6hjV97tkB7sgvxbdT7BCGQqTypkdtGkcJp5P4qxTxd1XVxALss3xIP8OG
         O77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rlwWVbQiVcz3Kh7NQqEYC+alrKhP9bgzfLkUvy6Bzck=;
        b=izdVcACKicRXkp3jE7GC9ZKq3TavJv1Z0K9bU9fBFJT0EtN1/nlsizG3mK67bXNn/l
         GAt9EC8JrOx5G+EaQKVkdezWn4MpyY41yAEkv5xAO8yQACA6RjPfDEphczhqypZ4CuQk
         AaseMjLypOqaK5nqHxq1iw9huAhLrqfLG14pnnl+4TabpVYHHpG+Wdc64XM4Hj+ruqdl
         sYgyEdZoV4smIamO2QUEd7c4Ukcp6TeyTfxQvLLUzXghk8Eiv+32/DOTe3Vf5ZVQAb5G
         ck8N2q52rdrIb9FRuSzJpxRmNGEXNTY115uZluGYk94SgSpDeDlURIr54W2pncOPoYhp
         rj1g==
X-Gm-Message-State: APjAAAUW7bsh/FmEkYGhQ4dX4FJO7BSWrCMRmdU1IyxdVFr85YCk8Ddx
        N/ODAKwKbdmX1cpKQjpZHJU50TS6NR4a9w==
X-Google-Smtp-Source: APXvYqxVYcmdjJvEGihFf7BIJPmtfmjvSwvapblLPTl2ISvS1pRtqU48U8vFVAPiE0fjmps8A08vaQ==
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr4994758qvb.202.1579616601738;
        Tue, 21 Jan 2020 06:23:21 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 24sm17537934qka.32.2020.01.21.06.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:23:21 -0800 (PST)
Subject: Re: [PATCH 02/11] btrfs: Make btrfs_pin_extent take trans handle
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-3-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7c6a9ab2-c494-3ed2-5dd6-1dd61f8f5414@toxicpanda.com>
Date:   Tue, 21 Jan 2020 09:23:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> Preparation for switching pinned extent tracking to a per-transaction
> basis.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
