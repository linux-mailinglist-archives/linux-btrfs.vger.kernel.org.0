Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BD78C4C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjH2NDY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjH2NCv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 09:02:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55677BF
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1693314160; x=1693918960; i=jimis@gmx.net;
 bh=HcgkruFFIkFiim895io5OzsHvx9/9WwXrWyivAP6flk=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=U3q33XNaWHVbUs1sE6Rdsdm2IJbha/isPrgpWBEr59YFVkn3Xw1siPYNDTJ2ZGm3hTSXVLp
 h0GkwGt+9d5bTy7kMYiaCmMj93obSOxJminLL1S7rhGeFpohZW3g2nbPVIRZnOEo0/JSkAlUj
 j1LEshXOtwYkV6ybOWGw8e7WR4PlKkff/zD09k0ihQnzcsecDD++A2DQ2u7VSrRV9oF5x084L
 9TpX8wrjpKMg82zsyslaZXYe9Q7FZCDfXURXi5t3ZOm3C85W17Hh902i0g+CZQJeuBUsIF8Rn
 Ismcbq8RY+yp7ZYPvVMzlK91T0MRg/6ONpTuKxTKNw+Qp+uAL+jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.65] ([185.55.107.82]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1pb8V618Fc-00zoRw; Tue, 29
 Aug 2023 15:02:40 +0200
Date:   Tue, 29 Aug 2023 15:02:39 +0200 (CEST)
From:   Dimitrios Apostolou <jimis@gmx.net>
To:     Christoph Hellwig <hch@infradead.org>
cc:     linux-btrfs@vger.kernel.org
Subject: Re: (PING) btrfs sequential 8K read()s from compressed files are
 not merging
In-Reply-To: <ZMEXhfDG2BinQEOy@infradead.org>
Message-ID: <62b24a0c-08e9-5dfd-33a6-a34dd93b1727@gmx.net>
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net> <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net> <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net> <ZMEXhfDG2BinQEOy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:gqPLRhTs9LrX6e/+xg3kh+MtmET4Z617agtwVr93D5ZmR6I10b1
 K+jWC/Do8BYGdJAHQoaC4iKdTUOxefWsuiOuXtup9ze0SawYQY9X9ZEY/0pUc48cw4jfn+b
 6J3tpjHwtYNWlXNKp6p6nY5DLgyb2K/f3Q2NxITTg467V4WPADtEzNJMncuiIET7j7+7uTi
 U1aWnLFlnswHmpIIcek5w==
UI-OutboundReport: notjunk:1;M01:P0:gaoTxPoEy3Y=;7ytWb9AeS0c7w0GpZwaQlbtyql8
 Qfukf6Xa9bznMng4jidKMhguiF+qk2jEDEmU79olKdoJ1Sio6sIGI4c79ynlbCH9g+3OH1BOU
 yM2moB4HWV0NB8XxZg6uHG9u3mEnMuFqu2U+5MxwbhrTtPqUWleGgpqjl6hy/kMNtCgqZr4ot
 tyDRs7s7FTMP0sgf4AiokwEbMTFaHfHmmGZh8g3AENrDT5aVxpuSzAO/YJm5o1rp0nMYzVYQv
 x7fShuHT3WGOPnmI4ax0NdbL5blzffYbFchsfclC33k9D5iWzr/IZkA+1IDCbNZ12qJ8rK9cx
 b9wwpYGqaaAgRT4w+1hLlnIDQ5flnk3x5QCPlLmsVYSIly6/Jifvh5bv0bwpK/GjbT1ao9Jkb
 lIf+Vnn1VLdQDYtKVHBiyiTwymLruku8wHaKidSTbNSyfb0LeFpJuH11UuTG5RSqPu9I30SKY
 5ML9zCJdVm4ypufkC2aLRNjYYieeQ0C0A6PxYExtIK46/YVQMDwfChQF1DKGTr9Ani2xrDi13
 N/9kzntse73orjKvxgY/Xm0w4Sn4uJdT7g90bMxVvLj1RXqNLnLefM2EuyYAx2hUUh6i/patO
 vodHqObbNgrFVGgwibT8etnX0JvhvWSNCnijoykGOttAq8racCW2sjSR8MZQrvf1MPSd6NoVX
 IatQACv8ARllhbYN+7utndZRf6hgCqrpngstT91Gn04ssDeJmOcvvHTXnuU6Gp2GF2EP8lYAD
 Vq4jEkUJVBqzm3E+woOafc+5iqM4/vAawmqOf3iENdor6nDq+JxathNABr8Jl80h4PLTD5Q50
 iqytYAWVZcabe4uadZmujzS88eK3h1uhs7uh3E6QLQgeH7+4SUf7hzY5kQ+ntRrPCmX9Sed9q
 BqFqljLIxRj0GP9c2bkM8YDkMM4O/CFhI84QyyJw7m+8C9y/HBTydzl+e
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 26 Jul 2023, Christoph Hellwig wrote:

> FYI, I can reproduce similar findings to yours.  I'm somewhere between
> dealing with regressions and travel and don't actually have time to
> fully root cause it.
>
> The most likely scenario is probably some interaction between the read
> ahead window that is based around the actual I/O size, and the btrfs
> compressed extent design that always compressed a fixed sized chunk
> of data.

So the issue is still an issue (btrfs being unreasonably slow when reading
sequentially 8K blocks from a compressed file) and I'm trying to figure
out the reasons.

I'm wondering, when an application read()s an 8K block from a big
btrfs-compressed file, apparently the full 128KB compressed chunk has to
be decompressed. But what does btrfs store in the kernel buffercache?

a. Does it store only the specific 8K block of decompressed data that was
    requested?

b. Does it store the full compressed block (128KB AFAIK) and will be
    re-decompressed upon read() from any application?

c. Or does it store the full de-compressed block, which might even be 1MB
    in size?

I guess it's doing [a], because of the performance issue I'm facing. Both
[b] and [c] would work as some kind of automatic read-ahead. But any kind
of verification would be helpful to nail the problem, as I can't see this
level of detail exposed in any way, from a userspace point of view.


Thanks,
Dimitris

