Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6A3A4221
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFKMml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 08:42:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:39015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231509AbhFKMml (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 08:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623415240;
        bh=19aLpp+8dHhivNTeB6/Ygrx7lTOnRVxVRS/ueE5Ncns=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ILh4x5jnMKFXzgKnHuS1n/Jrk7gQLc2vzhbWNfaD1tXP0WohpJ7t94qMwzVbxgfZo
         TXwzL8eEgTyOO6ZosaMb35gRGCZ7CuR2+OuLldtAO0n/cCLuzbpqq7uPnzcbRj2qXE
         cI5nomQojK/BoG58j8ACoGpXym26wNocced25sAw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSc1L-1lklVH3hzF-00SvNV; Fri, 11
 Jun 2021 14:40:40 +0200
Subject: Re: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-9-wqu@suse.com>
 <PH0PR04MB741678D81425B3F3E24DD28D9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
 <3542ce4c-f2ce-c834-6866-eee6c28a967e@gmx.com>
 <PH0PR04MB7416BE7F9C7820B29E0EE18E9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <64dc7f0a-b0bb-251a-c7bc-553f020ae411@gmx.com>
Date:   Fri, 11 Jun 2021 20:40:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB7416BE7F9C7820B29E0EE18E9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ljZmmUReYBXMXp8nbjEFAVSNffglZ245I8e5cBJoceIAUpdEe4K
 pVGfP42oK6Tbaq3vtF2B3CjBvFBHP7fyTnbz5oTjn4tJ/6XtgRpjNbDUCPfJyyvYeQ5bJdq
 rfkitqG5HcboLhk3nxsBKoLDh4MTSZiLXo6LO4HqRoRJvnLUG0sttFAtvomLpiBUunh94gR
 990RRNycEVJ/NIm9nO8Lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7AyJuad/Fbs=:P16EX343VkF6G4/wxzwMOd
 QyTc46IIlkB2LR/HcfEIloVCGafwrP2OgClqZEuEEiuf3uJ3sKUMjTn/Op7/o7vEgF3tTYLJT
 +F1v1ytPSJ3EuwGwMHkRNVmtOzgzJ7AdV/pEErNU3+Zsyk6lI7rYhJ3JvnfbaTTnvwdfZd99d
 KwN6vhkYQr3ffrwWD9n2rU6AIoz1ZrT9apdxxS1gpqyEVGxXBLjpICTJsqMnM26zr/rZMoufU
 OD7xIRRveXrYbzKSPMCVp2c8wFvegaLXS1T+xVsPQ9C0RL2HfJvs9Cy3/2g2XrhF8SN6/1NiT
 kdOUQbbZT0KPNWit+bc6r+CBdyB7NqgnOlnHIi9tsrrhPhurKWu1fHdEk6S896utd90T+Orik
 AUrkUH1fvt/3XSs4ymIHNtyDLywsAlC7zMKS0blJsWOVXIkdwz4q86bjWdyh7klPkTfnMUq3n
 Gm4e9094CmD9HD9+p31s6pS2zHsZ+dnjBEwsUdWpxzS3yns/6cMYvzRvO7yK16qjkr6EKfD8j
 ePGI81RjnrEdHtlQkhlP+1GuXQXBD82BWjyYcPmPgrx6GsNWKIdjhdXLc4omhIYScCaDYtuuL
 8bTDFXiwbP52WmEeDbk3dfU952Jb0GXV29tDVz0KTH5abRNbSgnovqJaZ5iVwd4CtnMZdKMLu
 ifvaAmPX1cVa/sLJebk+bYCHrLWSjqgS80cHAxoS89EUOE4arWLynxNP/vcaliuKEPq0XAJ8x
 iFlt8SB5+oT5dyFYPAQg7mreRjjjIGLyrKwMhBYewli4vT1vDTHkILyLgi4qtzsj1qvs2n1OS
 y884DvWpYYhqaZh7iIPovz2RJfj8TiUBefB5J1uKxe1CEj2yxiJ1kXUomfWsOoPp1i3DUdO3e
 KG5d2JeyJicYQ6fslgjNub7BRRQYeAMjke4vI+BLeeivxnNozXRcqiiALg6m2EHj+K7lSpaIS
 OJZKFVNtVKuy0awjunI2lBiKL6nhekuXBoAlhbKeg4s/tYDDCmQ2ldeEZr5M+vUYvlgVj8l3i
 WWGLAvjOe7dLPbcLA9tDZccfwzjPK0pz0VD72JsEhPE77DIDeL5adAT+FoXrcgtBMiradQt85
 zZ5Kj3v5QWNjX0IQVcDHTLKczN7elERpA0k/0HBXPyQ4MGq54XcpzrfNA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/11 =E4=B8=8B=E5=8D=884:19, Johannes Thumshirn wrote:
> On 11/06/2021 10:16, Qu Wenruo wrote:
>> Did you mean that for the bio_add_zone_append_page(), it may return les=
s
>> bytes than we expected?
>> Even if our compressed write is ensured to be smaller than 128K?
>
> No it either adds the number of requested pages or it fails (I think the=
re's
> and effort going on to make bio_add_page() and friends return bool so th=
is is
> less confusing).
>
BTW, I have a question about the add or not at all behavior.

One of my concern is, if we're at the zone boundary (or what's the
proper term?), and we want to add 4 sectors, but the zone boundary can
only add one sector, and if we just submit current bio, wouldn't it
cause some problem?

E.g. we leave a one sector gap for the current zone.
Will that be a problem?

Thanks,
Qu
