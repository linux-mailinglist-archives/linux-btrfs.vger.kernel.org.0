Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D90483063
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 12:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiACLRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 06:17:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:47267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbiACLRb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jan 2022 06:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641208647;
        bh=xbU+BnCjAuBBROm3AC/+paaUGv1jD8dDTcueRW2fujQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=JutgIwjBv+Jq8h8dAffQysG+Yz68y1EwNlDifaRhcFTfeuZT3sRtBxAoVpjE/tzgG
         YR83fBHECPms7dRuOzITFHTN2Vbty3+MLTH1eAZMe4iG9jq1Mclx3B/qGNujfJgWvq
         iPKbWWmRYUU/LHrkPXvU0mmt6tB56xxJkD1vOlHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1mJ8U73SAn-015ZkQ; Mon, 03
 Jan 2022 12:17:27 +0100
Message-ID: <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
Date:   Mon, 3 Jan 2022 19:17:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: "hardware-assisted zeroing"
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G+ABRYCeifPZe3wDABsEmhIWGZoOSp2SyrSYrmnA/RcersVputF
 Yxj2mBeWtkyGLNeu6RMAhmLSE4sFpmf8lVKFVbw8jmMoNdo4pLhrn4XOPs9+XgH6eljF5cM
 AULS3AgXUOdB/eibo2hkNX+h89NM36XzcXx3coo9FHaHLZRKLKclZyozPQ+73iLD8fO5lps
 hTqPYJm++44Se0rsdlmKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7dg9tXjjj9c=:g6jMxLeU8tsTfIfxbd66r0
 3fn517IInKj975+2pt0aZPDQ0ueAxWkfKZjhqbn98gmdBjhy3xsztFCfzioIcijI36X+lhOsF
 BNqBEY5E8Lo0BxQFA47+kvBrMMhf9Y3NnHczRPXsMxULGXE/Jso5KwwS4f8JwCmkfrxbIRJEC
 NJtXlenpJy2d0XrYbUOA0Lw9ye2hyVVlOW2d7Vav9/LCfjyvG1dC5/j1XQ/5OemPumb52gQj5
 egp8zU4HhiN9iToRiP70Ga1zt0pXF/4nheXMj2IgYXl0zYSqS4yFUj+dZCh0cVDkzETaoIiSR
 fJD8UZ46iXhVAPXofef3RXyaMHCU5uc7pKNbQf8oVG8ChGOeBQCRNiJh90XLToqbD/mU56axV
 eJWhWvs5IAXt3aBQknOYOBC+4KGpciqMlHS2Y+NpIs6pMIdvlYMZ6E6zhbnbSxTiNXeS94hsY
 R9KJsRmKGzNyDXjjUxAXlhwmsD39Lu68oSe+Uaa51kEQST7avdvWpfyqMVruUESdWvoI4KyS8
 Al9MlfhBwjavnE99Hn5IR8qtKZUQxvZJkEokJUch+9fidTMkJ4NM79cwNRWSiq6BR0cP4ROlK
 QL8VsWXgWJbDfaNnYjQ16RZolEpO7BVQjXF8DCLxKR4CkCgMnHmiIDH1BEK6FywV5QS/IEn7b
 zlT3unKkiPhmTHrQ9dFhADIxdKHc5E3PjvZ6Xs1uppjhObtIzjbYlmlVzEZMO1TKjCz1jjakf
 uGChrPwslIcqmom6E+zyvhuOqAqIm1hqb9aAlHIJFKMRVVrmJ5DmRdLN5TV6LDrwYNKlLLMgA
 x0/gfV+umsdnbMRx+mfpne+dTJyCcZj9o3iKQqn0utca3qNYVvMKOkIe8SqZ3Ku2BlvzRTfoq
 SZDhfWt/RXjYHCmaY6MWvcD3uUIvCHBoPHc9/ORqMPLxpiIqCGx7hHuiUJP7nZ9JClfgL/2pH
 blqgudBLEAKnNW4laaDn57nEl7Bl4ezMZQzMdRpceJRUkEq5q3ma/ju+GmxDgx8K0QToSXS44
 3bXEfI97T6qRnhhqyf0LPnwtm1DXfipR+rL3qSqvaokFcD4pwyVfYoEP/ifXSpaG3351GXMoe
 rdeAxLyvAuJq1U=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/3 19:08, Eric Levy wrote:
> I am operating a Btrfs file system on logical volumes provided through
> an iSCSI target. The software managing the volumes shows that they are
> configured for certain features, which include "hardware-assisted
> zeroing" and "space reclamation". Presumably the meaning of these
> features, at least the former, is that a file system, with support of
> the kernel, may issue a SCSI command indicating that a region of a
> block device would be cleared.

This looks pretty much like ATA TRIM or SCSI UNMAP command.

If they are the same, then btrfs supports it by either fstrim command
(recommended) or discard mount option.

Thanks,
Qu

> For a file system, such an operation has
> no direct value, because the contents of de-allocated space is
> irrelevant, but for a logical volume, it creates an opportunity to free
> space on the underlying file system on the back end.
>
> I have searched the term "hardware-assisted zeroing", without finding
> any useful resources on the application of the term.
>
> Does it describe a feature supported by Btrfs or Linux? Is it possible
> for a LUN manager to "know" that Btrfs has freed space on a volume, in
> a region that had previously been allocated?
>
>
