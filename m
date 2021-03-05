Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6832F67F
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 00:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEXQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 18:16:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:41193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhCEXP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Mar 2021 18:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614986154;
        bh=SQ9y/tPPOZXY7epWef4F+ZRM/ZLK1veYalNHejtbuWU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RpIyrOyQvSvLmsk0QIfA6fEL8mHCB2b5oZzH29Iavc4n+v2Q66al0Mkle73M/rrRL
         3hOldIbvnPXOBkMccOMGk35A0EeD2gtdOAs1inzcjbAyVS4a1r+gsdCRBONVSNd8Gb
         t3JhM/5w2lI1N1Icsc65JEEx1/jMbuSxvJLXN9qA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlT2-1m0h272UDO-00jssv; Sat, 06
 Mar 2021 00:15:54 +0100
Subject: Re: convert and scrub: spanning stripes, attempt to access beyond end
 of device
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSv7BD-8RKhHdD_zhkqH=YnFqsCqidFXRSyWrCNoaBpeQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6ac08116-d550-b2b0-9ef6-79229ad00900@gmx.com>
Date:   Sat, 6 Mar 2021 07:15:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSv7BD-8RKhHdD_zhkqH=YnFqsCqidFXRSyWrCNoaBpeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQkAkJ+ZUGBH0g/fdY8epmXMHdZGeXJGfvOcHKd7WP00+2YfTyO
 NGXpj3lTye6vmZT/PbHKg5IPLWzkYl1lhJPmywTjwkyADTcFJHFi+cD1R0M3fnVokMADtLW
 fhr1UTYRW8rmSil7mWIaRiGOsKJrXIT2eqT11eZDxlPZgEpNdPRujvOXiJIcEMJgfbwB/d+
 PAakmVAIsohLMHHyYsACQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IYZiSVhZk5I=:X3FkrhstcYk51tiHI+oRHt
 0wPTqYW+L4DdAuyzplJ1GHeO329XGTyDzSgWp3tlenzCr23NzNQSLUTMAmChR5REsPRhrCrUt
 SbHMRMPy/bgAR58jzrbP6agk3eynEmZO6PBcsiSQ2eaBWWVAk+RnnbtISH8QsXMZkQCxokp3Z
 SuMjUO5WSLP87PYzr1BlWsiCzijz3ZDDsFSKyfA1sed6KLd7qAJ1R9ytq8Os0thP8hD+5Lt02
 HOm/ZAiEU4ScyQyE9xP6AdZHIaBmjJgtN4JWupI4A2ZdEq+QbD3PkFQ1M7H8dwcixmKJ4pQE5
 qQcbESsu+YA0hIc10Qd2HAMuwaAFgoBYaDbJl0htKoiMWw46AviV8HVVbD9u2OMbjkH9SAjAe
 JNPJabcaIL/RgFO03nD9usbg4LkcmmWYyJqPz60qI1xz2cGW/7/xZmeXHji0y0ZauorHsbakD
 uj/NjghUdt71u68Nw9PzRvPAiRS5L30jbCO6YuhZD7o1vigNUcy7lYE13H6H2zXk71Orl5FFk
 CDr24cwGd4YYe1MVKninL7hA0mXb6EOiAQnc6SEjcyg7nIAPL+nB7m0rl6iRIVTi8H8pUmeel
 eC4b5YlDE8OUJ9nohQ09PTrcBcUoplQOSNz3XwVxigxwoc0zKsBMPwAhHMlD+BwNokPHWBRej
 ic/eNazeID1Qt8DLsL9ITq3IPGrlb5iSp8MrbCACjXR6vXHa7ozdzyyN5szdYJWAnjWt0u3uq
 F+KXp3ftWbt6rddbT28I56SQ0MuDvM64j7wQ33aokrf8a9T7+nD/zifdSjbLkVqUzoKa1Vrhd
 VFRLYo/zQdbDCxjFYbuEufvyYzvIPkJToyiHWxDr7LPHROQVc5irF1tgla/BWxOQvrEmid9KA
 iaX22LtDRLuA2RyaWHAg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/6 =E4=B8=8A=E5=8D=881:26, Chris Murphy wrote:
> Hi,
>
> Downstream user is running into this bug:
> https://github.com/kdave/btrfs-progs/issues/349
>
> But additionally the scrub of this converted file system, which still
> has ext2_saved/image, produces this message:
>
> [36365.549230] BTRFS error (device sda8): scrub: tree block
> 1777055424512 spanning stripes, ignored. logical=3D1777055367168
> [36365.549262] attempt to access beyond end of device
>                 sda8: rw=3D0, want=3D3470811376, limit=3D3470811312
>
> Is this a known artifact of the conversion process? Will it go away
> once the ext2_saved/image is removed? Should I ask the user to create
> an e2image -Q from the loop mounted rollback image file for
> inspection?

e2image -Q would definitely help.

Thanks,
Qu

>
> Thanks
>
