Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7986C3501D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhCaOEO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 31 Mar 2021 10:04:14 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhCaOEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 10:04:01 -0400
Received: from [192.168.177.84] ([91.56.89.170]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqatE-1lwJe1282a-00mZ19; Wed, 31 Mar 2021 16:03:57 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Chris Murphy" <lists@colorremedies.com>
Subject: Re[4]: Filesystem sometimes Hangs
Cc:     "Chris Murphy" <lists@colorremedies.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Wed, 31 Mar 2021 14:03:58 +0000
Message-Id: <emf567b17e-42d3-4c32-b254-a19d06ed87c5@desktop-g0r648m>
In-Reply-To: <CAJCQCtQH=k_h7CyRLysea0NgqadPnOVtVTGzdU9pG69RRhqL+g@mail.gmail.com>
References: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
 <CAJCQCtQt83dXev6Ngo_tDPZFqD60eD3W3h-1ZT8KLc5hMcB_HA@mail.gmail.com>
 <em7b647410-6346-4e95-b97a-f45ee2de0037@desktop-g0r648m>
 <CAJCQCtQH=k_h7CyRLysea0NgqadPnOVtVTGzdU9pG69RRhqL+g@mail.gmail.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.1.1060.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:8gn2oC32Z2Dmy+/Dqoxk/Zq4/8fIQkHMQ6kBlVvNqSVXZEL4LWT
 hUUfPFXDCPQew968RwPBS4lSOCuVn8SLfEUaG1lFK7kSaJtnIS4YoxshJoRhIPpLegZMH9D
 cMF7gyv6NBH4SQ6eUFtdypL4OuQmbdzHQh1SsoP2vNIsCIUJn5BXVs1de/xhfoquWHp2sGy
 ePqdRwDyvfIF2r4wd4y7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xiQXZZN7wSo=:1rdIe3CMtgrFWk8LNVoXy5
 ug6QkjtYaWrws7clwWZ64kB02Lar8C/3XJYvZjmj6lDT8AZSpsREQHgwzORxy36zplzN9OPYM
 zbOE/R3muaQUJHNIVDMTDjEYlL+LBOiFNRKIKA29VJBe9pnRiWkwBax/eAyL8IeKyhgjRB330
 kTaZL9Wp7X/zsNYWvgIxWe/OBIn/Tcx0uphUIupMqimofNrx36sEqKgXE3CAWcrDZ+/TzRJ2X
 IuR24cXTLdgGwYnNqjcoT8hjrKCPE4yM3doyyXI9f7/4AcoeWKCz0gk0K9vliD4o5IpLX9bIn
 xCMNbFPoFOdxKQ0vSL7xgJFzrqNhnjlYon/a8DGMsQS8zKs20pk15tPjK2Cus2ZgIds91tDTQ
 XVPkZ0PKzXmV0JIGwFaF0ynB+ulOzVLgizlzzeAvNB1UqsGdfcPMv6VoSZU+AN26TUN7qNmkn
 9L4PhuguoHe2N0cUK7FnPCyZCeH+v+fcBBWJSy++dAYqJOmSnFPF
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Chris,

thanks again for your reply.

>
>>  5.10.0-0.bpo.3-amd64
>
>It's probably OK. I'm not sure what upstream stable version this
>translates into, but current stable are 5.10.27 and 5.11.11. There
>have been multiple btrfs bug fixes since 5.10.0 was released.
>
>I missed in your first email this line:
Ok, I am compiling 5.11.11.
>>[Mo Mär 29 09:29:21 2021] BTRFS info (device sdc2): turning on sync discard
>
>Remove the discard mount option for this file system and see if that
>fixes the problem. Run it for a week or two, or until you're certain
>the problem is still happening (or certain it's gone). Some drives
>just can't handle sync discards, they become really slow and hang,
>just like you're reporting.

In fstab, this option is not set:
/dev/disk/by-label/DataPool1            /srv/dev-disk-by-label-DataPool1 
        btrfs   noatime,defaults,nofail 0 2

How do I deactivate discard then?
These drives are spinning disks. I thought that discard is only relevant 
for SSDs?

Regards,
Hendrik

>
>

