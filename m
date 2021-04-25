Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90836A528
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhDYGnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 02:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDYGnV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 02:43:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D2DC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 23:42:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m11so36874749pfc.11
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zRDOvyLADTlPAGowjU4Ll6nuFg3Ygufj0K8xGuxkJj8=;
        b=pP02udJcODXzNIyA83sNsea0oxXHFdn3Ot2QCKYj3e1qzRkDguJlV26DGtgD/QLiOc
         SApgyKJtNCF72TZBhg8Suxs4YnqzwkB2sscVM84YEEFoKkvzC5IbMmZCK+cU2uNJYp4W
         ffR5O4cb61jEIzZAuKB96z7uSbozD7BowH0qwlTNvbPQLa/exjOg6kCtvWTQuXZanT3V
         PBP2DB+PKEp1EczvT1h3DbDKuLpRc5HJTw0jRNNzZ8JRHr5UHEE5D6PCcORgopLEA8J4
         rNt6mpvNUl7Oc5gbuNdbpeBiUJZcGKlx13b6F5cMrTAjWJxAST1ESoh8ETYMgMT5SGZX
         3OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zRDOvyLADTlPAGowjU4Ll6nuFg3Ygufj0K8xGuxkJj8=;
        b=naFW0gMmrhF0ZEqT6m5a32aF2vdEWto4+rRjbbCYe9ZlO7K9dbh22xGr/tnCQWlRtl
         eYFcBZSUTlB5s5paAeYhGncnBmAPacsHS74nwGqTTYxv+5Ai7v3bZVcKCAQrnHMSGB68
         ZtOgg+qjBj09zRjQ6hkvCQDtMZgLbWd5rEg4FFqXawiZx22YNLm+w5UYpJAT3IWSOJ94
         mCxYaBJ6sYjh9Lnv7d9HC121O4xilgfFwCfqlsoJElyqOFIQS2SwYgg7o1Xafc/Vz6YV
         8cEVPtLmWXkfZyOE7PnIWg0+aqoCdzltwJgR7kZoIm7Jkvy0INMQ6NfJ7duk1TU9OUzo
         d9jw==
X-Gm-Message-State: AOAM530Q7IPoEnxXv/5jAJ9FKw6CiuzWBvQZWAln1VgIhEFrn4ZExhGo
        Xlb8jbbd147YLvz2/1iMbQw=
X-Google-Smtp-Source: ABdhPJzJby13Ka/ZBuR6eiWrTpDA59aWIC7BMU0RihCXeXUaRK8HHATfo0dau961LpMB76zbFNAMWg==
X-Received: by 2002:a63:e242:: with SMTP id y2mr11598119pgj.298.1619332960811;
        Sat, 24 Apr 2021 23:42:40 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id nh10sm207324pjb.49.2021.04.24.23.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 23:42:39 -0700 (PDT)
Subject: Re: Restoring a file from damaged btrfs raid1 shard
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <9ca589ec-26b1-1b92-fe4a-af9006e516c6@gmail.com>
 <CAJCQCtT6iNwN20uHjv4FPs--6_j34XpmD=6M+_Jkt7AiBcvMag@mail.gmail.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <351b947f-0d7d-9c2e-e629-277da4d4efa4@gmail.com>
Date:   Sat, 24 Apr 2021 23:42:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT6iNwN20uHjv4FPs--6_j34XpmD=6M+_Jkt7AiBcvMag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/24/21 12:46, Chris Murphy wrote:
> On Wed, Apr 21, 2021 at 9:24 PM Konstantin Svist <fry.kun@gmail.com> wrote:
>
>> Superblock thinks the generation is 5857883
>> Superblock thinks the level is 1
>> Found tree root at 4883439714304 gen 5857883 level 1
>> Well block 4883437158400(gen: 5857882 level: 1) seems good, but
>> generation/level doesn't match, want gen: 5857883 level: 1
>> Well block 4883434635264(gen: 5857881 level: 1) seems good, but
>> generation/level doesn't match, want gen: 5857883 level: 1
>> Well block 4883426295808(gen: 5857880 level: 1) seems good, but
>> generation/level doesn't match, want gen: 5857883 level: 1
>> Well block 4883417972736(gen: 5857879 level: 1) seems good, but
>> generation/level doesn't match, want gen: 5857883 level: 1
>> Well block 4883409846272(gen: 5857878 level: 1) seems good, but
>> generation/level doesn't match, want gen: 5857883 level: 1
>> Well block 4883352633344(gen: 5857877 level: 1) seems good, but
>> generation/level doesn't match, want gen: 5857883 level: 1
>> ...
> You can try plugging these larger block values in, starting at the top
> (most recent) into 'btrfs restore -iv -D -t $BLOCKNUM' and see if
> it'll work.

# btrfs restore -iv -D -t 4883437158400 /dev/sdb3 -l
warning, device 3 is missing
warning, device 3 is missing
parent transid verify failed on 4883437158400 wanted 5857883 found 5857882
parent transid verify failed on 4883437158400 wanted 5857883 found 5857882
Ignoring transid failure
bad tree block 5246265278464, bytenr mismatch, want=5246265278464, have=0
Could not open root, trying backup super
warning, device 3 is missing
warning, device 3 is missing
parent transid verify failed on 4883437158400 wanted 5857883 found 5857882
parent transid verify failed on 4883437158400 wanted 5857883 found 5857882
Ignoring transid failure
bad tree block 5246265278464, bytenr mismatch, want=5246265278464, have=0
Could not open root, trying backup super
warning, device 3 is missing
warning, device 3 is missing
parent transid verify failed on 4883437158400 wanted 5857883 found 5857882
parent transid verify failed on 4883437158400 wanted 5857883 found 5857882
Ignoring transid failure
bad tree block 5246265278464, bytenr mismatch, want=5246265278464, have=0
Could not open root, trying backup super

From my very limited understanding, the older generation info should be
on the disk, even if the newer one is mangled somehow.

But also looks like this is not happening..?



