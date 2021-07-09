Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B413C1FDD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGIHP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 03:15:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:53417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhGIHP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 03:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625814775;
        bh=JAl6Zi1wOiNbZiUmdKMd3T6NLQtnUuhXz1w4Hnp5SYk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GLOo48x6I4mG7l1BMboTZdecGYYmITnKg9hEK9mz/oIXwj6q9IT13A0v7Cp/vqre/
         MGDhTxhunZuH0wPyg3bUmHOXHo/fbqO7mOgKx81Ii/9iDpYpcS0uq/4bDifEM8AqaG
         bp72S/D4Zw1R4ACxpakzeAVvMS5k7vVQtDKcn79c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLzBj-1ljoIh1qAD-00Hz4a; Fri, 09
 Jul 2021 09:12:55 +0200
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Neal Gompa <ngompa13@gmail.com>, David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1625043706.git.dsterba@suse.com>
 <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
 <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com>
 <YOfwuQPtXScmFULF@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <dbddba2c-9242-d8ab-3969-86e7b2974727@gmx.com>
Date:   Fri, 9 Jul 2021 15:12:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOfwuQPtXScmFULF@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wLB/sI7uefEp1C+VKfIKGqe5mA9H5YCq0TlaVOWfaZExxmziDWz
 Hl7cXB3p8xAPsQ6p+dxxUy6qWM2dFhE7MPpIEYciGYf8jqhtdAlXt17JSOUQgkv3J4xUOjg
 noJIewt5QpzKYEXPgB1kdhExh3NNeNSJttwCM/KpAccttnOGAhzEXYCa/CFnQX96gCyygbT
 6HpObxXd+0gzezT09lgDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VAXxrW6lbMY=:C4WU0EmBHykpYG5wqJE3sr
 4b+7J5ntlY6dTTb2O5rwZ23wIwTt8OAf4lPhOvYEsVxHK7T5wIvXNkcO76lqsQzvA2nhzN3xx
 2/OgZt19mIuc44f+EawCz37iZVt+eEkPCHZRd5P/GClBoBL+6nz6cUCObs8tkhxI3bmEY2/JD
 CxdMbMNpa7Gtr6CaMOYebV9ugxFoAmFYmLjG9xoe//rzypnoxqv7WSg8R+0wF9CZR6e5TuNQV
 GOZJ+Mc1fB0vN1TV1pvQtKRLuT2UwJA5V7sQl188WJklsmg/CDbNXPolfhCLcCHArGuuhKE2G
 hw0pdely9LsPwYEfoUQmAk72I9tBt9ddmwDsNW7h5PeHF9Je5/6s63cioqOrNUZOCGulIhvmK
 tOrm5tZlhDHH2X/vCD+cvhHD5D9BB/BV+zaV8bbEK9jYb+kDfphO25FuwcI/FjSJSaXodWDWk
 WKz8+e/Ryz193aBXl6U/j1d9Ql1Ovncv9KZkarFoN7Oa0m0dBEbe4jlQf64o57BYFio+eSpXJ
 z4e5MGuLhIZ7VDq6h9lo4eeqPc0au3BBY73Vf2ZHmidgFT5YT77lQEqAEwBOJu0GwLluJXhoE
 BpXbjQrb85P4eI1LJcdiF4KyeZIL6g1WYi67fYl7H9spbdpN7hXU1/uSVvzCiEQS/NmT74AKq
 jX27bnR1Oyi0hRuqrM/ZjF+nyNcIFcuDddN2hwvNXc9cBLxaN2Hn7XsreehyIqdsA9uZYX2a8
 BRHBmojeJ4k8o4EDdINysZsbtLCZ8oUz1dT9/WKml0ygKkKDEAgMqjh0AQ5193m2pcne0kVIh
 LJ/OE5YVb5T/Xwm8FhlVCrhNuHWOp/WSL5U59xXGGP+j5MsqqJxZ3KdQ6QBPETRmvuag0EGQk
 0vv5GN8zn0H4mhz9zwE9P4TxQYRhQftpnidBzN5fayb9XUFYvo+ay+7Hv0de+Yax0/nTcvaIW
 Qf1uuTxaqPcC7DkZIl5zTPPhpMibpeVFEdVj+vLHSIpXSARxzMwv2FvjQ6mKX2Xq8CM5mUJ8z
 S53Tj/e3+boZcKsV9nWUxoFAiWBs45f0Tt8wQ5E0vqHQdD3433JOBQyXwm2+pfRgTTXFiJBkl
 zdwxUzIGN+AZnUQPR1OJ0HepW67eEPwA4eEMffojbv3KdB61KTBulrLLA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/9 =E4=B8=8B=E5=8D=882:46, Christoph Hellwig wrote:
> On Fri, Jul 09, 2021 at 07:53:39AM +0800, Qu Wenruo wrote:
>> Sorry, I can't see the reason why it would cause performance drop or
>> higher memory usage.
>>
>> The point of HIGHMEM is to work on archs where system can only access
>> memory below 4G reliably, any memory above 4G must be manually mapped
>> into the 4G range before access.
>>
>> AFAIK it's only x86 using PAE needs this, and none of the ARM SoC uses
>> such feature.
>
> Arm calls it LPAE, but otherwise it is the same.
>
Yeah, and I have never seen any toy ARM boards using LPAE neither.

Either those boards have too small memory to bother (<=3D 4G), or they go
directly aarch64.
(And most boards are even aarch64 with <=3D 4G ram, like RK3399 or Amlogic
SoCs, they are aarch64 but only support up to 4G physical RAM).

Way less historical burden here.

Thanks,
Qu
