Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1406FCB8FC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfJDLTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 07:19:08 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:37321 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfJDLTI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 07:19:08 -0400
Received: by mail-qt1-f181.google.com with SMTP id l3so8021218qtr.4
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=52SdMvMjQtgmCbFkfz6KK/2a3T5WR/jG/PUmZmGuDeY=;
        b=BtGHvKURqkdmJWK2cYyRoh16lSRBBInRxjuQ34pv4CeMDUQqXppllRAjzE4rkkvKwE
         Bvv4iO7N27YuB23GzADs1j+FmQv0hutVG5VROjbqDQEL+eAdhBC3WxtFRkEz+3AxFLzf
         EZUaAB8afDq4OvI6z4YPx5TuO1Sv3Vs1VBVOXIItns+pLG4tUmoZhY/Xd4UT/y/8cbt+
         XYy7dcEmT7NImXLzaetFDqVKyeP9nH78SIZjTBADWPk/XunSVszVF4HL20dFNe+SZYKX
         UZCOnKjNmCUFZAWFVEQKIb27xGVqkV4Rg0m+jXK/NDcQjpMhFMc6O9MDHptcdfwhndqF
         smTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=52SdMvMjQtgmCbFkfz6KK/2a3T5WR/jG/PUmZmGuDeY=;
        b=bVuWGZScPcVOg8+A2krlUAmMX2dA/+zbDSSpXZruFFGasTvBc9Y0egGVdc1LgmklrS
         w0aV6RaEGVPhoZaoqJkbtaS7SUxvUQPb/gQcNWZUZxAhOoJ5fhD0n6XYdYQRLbPm2SVD
         L379QXdRllorw9g31H5oF4nC4L7eQ5pUZx5UdEXXIDdKVJGgEFwgVl1Yzyg3Nl6MAPgH
         eFEbSbFMnwcbsSTyWQ5tKYaRk+x+0fwMo5Dzxv0dFDLG+0GpotHMvj2odmogZ6/vFy96
         1YQq1HrYcjK3ir53Df/H2inE+rGtTnp3IQVERL8OWv0LbP2hlO3ICACS9N6jgnGXjgAJ
         ynFA==
X-Gm-Message-State: APjAAAVcmuw6Ys73hjwppGfUZVmmf9lxWDeOURPZHC2Tcq3fGhIQzYbU
        wKT01TBj2dtPeVLkMJX4Y5Y1ru+sTqE=
X-Google-Smtp-Source: APXvYqwVxFRoqBxklQM+wka/HrJvNwk1aikN2AxmPq5AiyhJdssBgxaKx7FNMdkKmNF90Z+W2Yb93g==
X-Received: by 2002:ac8:2dd8:: with SMTP id q24mr15427656qta.118.1570187947413;
        Fri, 04 Oct 2019 04:19:07 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id o14sm3632034qtk.52.2019.10.04.04.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 04:19:06 -0700 (PDT)
Subject: Re: Intro to fstests environment?
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <f788c1c6-8a8b-e724-e3dc-6f1311002307@cobb.uk.net>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <84435945-21e1-ec53-86b1-3924c63691a1@gmail.com>
Date:   Fri, 4 Oct 2019 07:19:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f788c1c6-8a8b-e724-e3dc-6f1311002307@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-03 13:51, Graham Cobb wrote:
> Hi,
> 
> I seem to have another case where scrub gets confused when it is
> cancelled and restarted many times (or, maybe, it is my error or
> something). I will look into it further but, instead of just hacking
> away at my script to work out what is going on, I thought I might try to
> create a regression test for it this time.
> 
> I have read the kdave/fstests READMEs and the wiki. Is there any other
> documentation or advice I should read? Of course, I will look at
> existing test scripts as well.
> 
> I don't suppose anyone has a convenient VM image or similar which I can
> use as a starting point?

Theodore T'so has a project on GitHub called xfstests-bld [1] to 
automate setup of an environment for GCE or Android or a QEMU VM to run 
xfstests.  That's probably going to be your best bet as a starting point 
as it not only has a bunch of the infrastructure needed to build such 
things, but also has good documentation.


[1] https://github.com/tytso/xfstests-bld
