Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9DC16609B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgBTPNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:13:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36126 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgBTPNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:13:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id t83so3878204qke.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yjKrfOgohnsQm9GOW20cIij1yGSFbOJkM4Cy+u94Mnk=;
        b=HAsTn4SKTtrbgTjg/ncmW+7HBbRXSP/h6uZ3q/yIKwpwXYMn//rqaT8FcDw1rwNte/
         ABCZC2TJZJmIPkfODxSEtlvH4OLOwqOQhi/EBLwY0/VpoTOvpH/bll/p8kkV6KJgnVo9
         vWc2MkpDk3zpa7YRCwN8TDAQV/YzxxIxWvNPodJWdfRrWrN24QZeqEA5eRhmjxGJDRcF
         EWRR07pPiQZAP4GTyKww5tyVFIQL1TjisvRrWCPEdyuxhNAVqp0MQMGF6BwaVnc7tu9J
         143pZty/C60mXnMrU3xGC/kpA3wye0+3L8chVqY7KJz6X8F/Kh8iSB2+BR4Njf8sb2Y9
         YmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yjKrfOgohnsQm9GOW20cIij1yGSFbOJkM4Cy+u94Mnk=;
        b=M+iUNWwqptUtym1NY23sDHncwr+XDe3ryM4jvPwAC3DjraEelJjOx4Ds1RdpgoyaTQ
         MCyc9wrBZZQSyxN8I1xwcxAzbWCUr0SQDEW8mP5lImaAQWWFVw2ciQuM42+pKIUgMVk1
         54BBgg4OHxXpvWVs3mACGw2rRLRM/XpedPY48+S9ifX3FlG15UqgrqaOXatDse2GRS3K
         50x4jlX/enCTzBJzuvqC//75XiTNSzCd+78+vnBRmS2fASbqGbGG5wpnyN+YB/2mqVj3
         79YTtdWspg5YOF1FmJiL85+BA17BIXz9NoaZhP9XWmfSksK0bRB5/EUglGrrHPvBPU0K
         0Ljw==
X-Gm-Message-State: APjAAAW82jFftHd/cSKGxjiBzdFINvpifKiFGwMwmtKAXvkdpyIvWbKn
        lSE4aBhdBo0sCDmDQj79RNuFb5RsJLw=
X-Google-Smtp-Source: APXvYqxWom4FVY7sujCKbM4shQvmhFmASdaDpehDYjdp/QVj8abIVii4eRFnGr5YUZE816MA+mca7w==
X-Received: by 2002:a05:620a:542:: with SMTP id o2mr28503599qko.318.1582211586748;
        Thu, 20 Feb 2020 07:13:06 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 139sm1752664qkg.79.2020.02.20.07.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:13:06 -0800 (PST)
Subject: Re: [PATCH 2/4] Btrfs: simplify inline extent handling when doing
 reflinks
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200219140556.1641567-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c1f63392-ef54-48f9-e04c-74f72641142b@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:13:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219140556.1641567-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 9:05 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We can not reflink parts of an inline extent, we must always reflink the
> whole inline extent. We know that inline extents always start at file
> offset 0 and that can never represent an amount of data larger then the
> filesystem's sector size (both compressed and uncompressed). We also have
> had the constraints that reflink operations must have a start offset that
> is aligned to the sector size and an end offset that is also aligned or
> it ends the inode's i_size, so there's no way for user space to be able
> to do a reflink operation that will refer to only a part of an inline
> extent.
> 
> Initially there was a bug in the inlining code that could allow compressed
> inline extents that encoded more than 1 page, but that was fixed in 2008
> by commit 70b99e6959a4c2 ("Btrfs: Compression corner fixes") since that
> was problematic.
> 
> So remove all the extent cloning code that deals with the possibility
> of cloning only partial inline extents.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
