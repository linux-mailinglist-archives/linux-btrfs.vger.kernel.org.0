Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60620BDB2
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 04:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgF0CG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 22:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgF0CG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 22:06:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61206C03E979
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 19:06:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f2so4949712plr.8
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 19:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=aDlUM7yLA7WpzTF9ioPYyl89rv33+QjScLUR5TVf6EU=;
        b=jYSttoG2iq+c+PsLC1JFSRtmePkg+QtmhRhuCseBIqAR1xCNACIIW/s3CKB3qNzPIu
         NRfdkqDd9Hd0EWQdd3NK3al9wgt3lK+d1UxRaJz/155cqbZ9ajnCWu1oG+WSyzEjTkwB
         nvniRHqHllZT94ZfQ4JBTGuvuVLqIVLK4C+NeUl7toKJ/k1kWxOyHC13E576YbFlU2L0
         XRJ8bDlpvOiM5okW+hsjtXGe6uqrP9y+j1UoL5omnJU+9p0SfGnadCISf80MClXRbSwN
         etHUnIF6sb2MNiJ5J857e8SQ1HrgA5JS58Sgw+ck/LL34CG19f4LGzpuyHqhjQGufuW6
         AlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aDlUM7yLA7WpzTF9ioPYyl89rv33+QjScLUR5TVf6EU=;
        b=MqenW3AhC2pcaCYxe0XlW4gGhxmsNMY2pxCWrzqeAPslIVPjOQ/xUL64Jfa0DjS0of
         O+ZPpnt+6PwUl530e/JkJsQP/RLlSH+bwgpj65SRxHYd1vyBQ0vggfOC3MBXOVfnjr+V
         xIkOZ7hj93XPHUAkzK7h413hJu83pILb4CsFwOmDEjxN76H1XtMvTcwIGGdcKJYnJTpk
         C3+LNleSpyfVauN0ZUZIVV3Zb3wN9QA7dwfJY4JuBhTilDEAk2E6mMuG+g/KRo6p8oiS
         Jvreo6kKPbHzXX+QppPexI5obpGd8yJ3AanfYZoncZNk8weSCfMq3W5uTu4Bnzd+cnJt
         sD7A==
X-Gm-Message-State: AOAM533oA5iw63Xnq9eM7IXtv+p/dxGUVzj+46fB1ASTpeSVJv+TVWVL
        nkymJ72svSYe0AbKlZcSHObrqdfm
X-Google-Smtp-Source: ABdhPJypa0jSMsa3iHmDa0gcmV4xGURKQtma+4A/0W+hKBvtcfOmENcPOTeiIEiN1IXKbnHGCHfSmQ==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr4772734plp.311.1593223615748;
        Fri, 26 Jun 2020 19:06:55 -0700 (PDT)
Received: from [192.168.178.53] (115-64-226-52.tpgi.com.au. [115.64.226.52])
        by smtp.gmail.com with ESMTPSA id i12sm27257184pfk.180.2020.06.26.19.06.54
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 19:06:55 -0700 (PDT)
Subject: Re: RAID5 scrub 1 or 2 disks at a time instead to speed up
From:   DanglingPointer <danglingpointerexception@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <75eef36f-b85a-9ec3-2d77-df646c536712@gmail.com>
Message-ID: <207e1baa-1eb2-0d98-08f8-25fdf07fda70@gmail.com>
Date:   Sat, 27 Jun 2020 12:06:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <75eef36f-b85a-9ec3-2d77-df646c536712@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Does anyone have a view or opinion on this?  Is it completely wrong, 
misguided what I'm saying and not possible?

On 25/6/20 8:23 pm, DanglingPointer wrote:
> Hi All,
>
> I continually get frustrated each time I have a scrub a btrfs RAID5 
> array due to the slow rate.
> I was wondering if anyone has tried or seriously considered scrubbing 
> 1 or 2 disks at a time, instead of all disks engaged at the same time 
> (perhaps a division check on number of disks before start) to see if 
> it is indeed faster?
>
> Zygo Blaxell mentioned the above idea on Feb 6 this year.  Just 
> wondering if there's been any serious thought put into the merits of 
> that idea?
>
> The array I'm running the scrub on now has 7 disks (5x 2TB and 2x 
> 6TB).  If it is a question of diminishing returns on speed as the 
> number of disks increases; perhaps we say up to 8 disks then do 1 or 2 
> at a time sequentially, then over 8 just do default like right now?
>
> If it is indeed faster then it would make the uptake of btrfs RAID56 a 
> lot more friendlier and decrease the amount of flak it gets in the wild.
>
