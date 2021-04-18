Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF66C363426
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Apr 2021 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhDRGhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Apr 2021 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbhDRGhv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Apr 2021 02:37:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE6C06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Apr 2021 23:37:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r128so24087009lff.4
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Apr 2021 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xOLkK54K6ukFdoxb8kGYc5unJce38owUkQpyT9Xc5Jc=;
        b=SsMYfyd4tHsQuYDUDhXlQSVy8zRLkHtpUuSjeaj2anUtBhtWhD9CHCwzaO1UVynUAA
         JCOn4PX7v87JoPVDUBFd26Qyr3Tqhk6lyBKoA7/pEIdiGwTdp2k1Y1UOmd4AaUtJDNFs
         snRBEApREKwiB919gpQn3F5yMmrYMETolaxnojawAV0HjWSAycBGNHBqYm0XtvpnaeJj
         PPcoMIQK6V5jIAi/DnrFS80iFyoEGAWO7VVLFCgmmkaA3bCXRjMb4MGLxoAPp7GCAd5e
         rNAkuBjFgLluXp7ZgdZKRoJ02jjfg2qQSbt0WgdiPAAUPSBGb4UndsrNZxYxMiLfD+ii
         u+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xOLkK54K6ukFdoxb8kGYc5unJce38owUkQpyT9Xc5Jc=;
        b=bvagapqVZnPW6vAjQJwue+LwICFttVk36R+RpEAGo6AaTWSqJWe0Wbfgb33nL+ujq6
         Bo6KQ6bOa/2JqaaHXGg1wTF3TFVNe09cEi9Ye45Ej16/uVZe3loFUpX4KX3iuJb54dyi
         5z+H0GpYCN43iHGh/K38O0aHsaK3VVLliIG9ngDNjCKCpPHcjkrzFW2rtMCjjq1lLcqR
         iCbh0k2s8lBLg4Nn8ZdMS0wXynQ3rAbgwnRNjkL+DFtva29cJm6F9CqlbFqtP05RTf5S
         Ey10nj0XhLQyyC4XccrpBD9UyqsNYBfxXv40f+j+cl/fzZS6uORCzxfROO6O0sIzd3uS
         4dtw==
X-Gm-Message-State: AOAM5323dBbu+bsZUsleTC6/EB35uodDZkmvjHH0Thyc3ljooOZDb78d
        Kb0gTaH9E0eqHlIbCZvHVxHAWEpJQsA=
X-Google-Smtp-Source: ABdhPJxCJnZSsq6VFTd8h6TV+F47OEbAP2J6SXSZVBBvlAAvUhtTBk2YjkUuViu8W7Hydxx3NhdDog==
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr8182035lfu.646.1618727837712;
        Sat, 17 Apr 2021 23:37:17 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:be19:6dbd:a91:f761:1766? ([2a00:1370:812d:be19:6dbd:a91:f761:1766])
        by smtp.gmail.com with ESMTPSA id q12sm1464227lfe.96.2021.04.17.23.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 23:37:17 -0700 (PDT)
Subject: Re: Fwd: Interaction of nodatacow and snapshots
To:     Ross Boylan <rossboylan@stanfordalumni.org>,
        linux-btrfs@vger.kernel.org
References: <CAK3NTRCPDJSCnOiKSUK+j6wi3yLSH1JG6fcjaSuQwyjA7VESww@mail.gmail.com>
 <CAK3NTRDhRAC4b9NXTwPARAQirt9z4ZNrwxLNQ+7mL1dehMB24Q@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <fdb85a83-a2cc-77e4-3a46-b82bd5421afa@gmail.com>
Date:   Sun, 18 Apr 2021 09:37:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK3NTRDhRAC4b9NXTwPARAQirt9z4ZNrwxLNQ+7mL1dehMB24Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17.04.2021 20:27, Ross Boylan wrote:
> Suppose some files or directories on a subvolume are set nodatacow.
> And then one creates a snapshot of that subvolume.
> And then does a send based on that snapshot.
> 
> What happens?  I've looked through the documentation and can not tell.
> It doesn't sound
> as if nodatacow is consistent with the whole snapshot mechanism, but I
> don't see any
> explicit statements that any of the above won't work.
> 
> For example, I could imagine any of
> 1. the snapshot or send command refuses to run.
> 2. the snapshot completely omits anything that is nodatacow.  That
> would probably be tricky since the
>    directory with datacow above the object that is not datacow would
> need to be altered to
>    omit the reference.
> 3. the snapshot does an explicit copy (i.e., duplicates all the bits)
> of all things nodatacow.
> 4. the snapshot always shows the current (on the original subvolume)
> version of the nodatacow files.
> 5. results are unpredictable and unreliable.
> 6. the snapshot removes the nodatacow attribute from everything on the
> original subvolume.
> 7. everything works fine (this one requires lots of imagination).
> 

nodatacow disables CoW for regular writes. Snapshots will unshare data
on first write, so each subvolume has own copy which continues as
nodatacow in each subvolume (subsequent writes will be in place).

Unsharing happens for overwritten data only which can lead to
fragmentation even for nodatacow files.
