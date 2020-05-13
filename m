Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EF1D12F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgEMMlr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 13 May 2020 08:41:47 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48452 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEMMlr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 08:41:47 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E797C6C00B8; Wed, 13 May 2020 08:41:46 -0400 (EDT)
Date:   Wed, 13 May 2020 08:41:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "miguel@rozsas.eng.br" <miguel@rozsas.eng.br>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to find the parent folder of a sub-volume ?
Message-ID: <20200513124146.GB10769@hungrycats.org>
References: <CAP5D+wYLQUh+XqBCU3MVq1vY41fbPgjabm7GkORmio+kFOYaqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAP5D+wYLQUh+XqBCU3MVq1vY41fbPgjabm7GkORmio+kFOYaqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 12, 2020 at 02:17:19PM -0300, miguel@rozsas.eng.br wrote:
> Hi there !
> 
> root@fenix:/home/miguel# btrfs --version
> btrfs-progs v5.2.1
> root@fenix:/home/miguel# btrfs subvolume list /home/miguel/tmp/
> ID 265 gen 20670 top level 5 path miguel
> ID 266 gen 23573 top level 265 path miguel/Documentos
> ID 267 gen 23575 top level 265 path miguel/Downloads
> ID 269 gen 23537 top level 265 path miguel/Misc
> ID 270 gen 23522 top level 265 path miguel/Musica
> ID 271 gen 23526 top level 265 path miguel/ProgramasRFB
> ID 272 gen 23574 top level 265 path miguel/tmp
> ID 273 gen 23509 top level 265 path miguel/Videos
> ID 274 gen 23574 top level 265 path miguel/R
> ID 275 gen 23557 top level 265 path miguel/Imagens
> ID 302 gen 23507 top level 265 path miguel/Tech
> ID 595 gen 23517 top level 265 path miguel/src/UPSData
> ID 596 gen 23510 top level 265 path miguel/bin/UPSData
> root@fenix:/home/miguel#
> 
> How to find the parent folder (root tree?) of the above sub-volumes ?
> On this parent folder I expect to see the above sub-folders as regular folders.

If you want to have access to the root subvol, the easiest way is to
just mount it:

	mkdir /mnt/root-subvol
	mount /dev/... /mnt/root-subvol -o subvol=

(note the parameter "subvol" is set to "").

A btrfs subvol can be mounted multiple times in multiple places, so each
application that requires the root subvol can simply mount its own.

There is no general solution for accessing the root subvol through
an arbitrary existing mountpoint because the root subvol might not be
accessible to a process (e.g. chroot, different namespace, etc) or might
not be mounted at all (e.g. mount -o subvol=miguel /dev/... /path/...).

> best regards,
