Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667461D0AE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgEMIed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 04:34:33 -0400
Received: from www.chrestomanci.org ([82.70.68.182]:42856 "EHLO
        mail.chrestomanci.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMIec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 04:34:32 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 May 2020 04:34:32 EDT
Received: by mail.chrestomanci.org (Postfix, from userid 118)
        id 18E8836D9; Wed, 13 May 2020 09:27:05 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on jupiter
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
Received: from www.chrestomanci.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: david)
        by mail.chrestomanci.org (Postfix) with ESMTPSA id D629F74F;
        Wed, 13 May 2020 09:27:03 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 May 2020 09:27:03 +0100
From:   David Pottage <david@electric-spoon.com>
To:     miguel@rozsas.eng.br
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to find the parent folder of a sub-volume ?
In-Reply-To: <CAP5D+wYLQUh+XqBCU3MVq1vY41fbPgjabm7GkORmio+kFOYaqg@mail.gmail.com>
References: <CAP5D+wYLQUh+XqBCU3MVq1vY41fbPgjabm7GkORmio+kFOYaqg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <ee4c18f1b87cebd2875d684e4b7c769d@electric-spoon.com>
X-Sender: david@electric-spoon.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-05-12 18:17, miguel@rozsas.eng.br wrote:
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
> On this parent folder I expect to see the above sub-folders as regular 
> folders.

Use: btrfs subvolume show on each subvolume in turn, and link up the 
subvolume uuids

If you can read python, I suggest you take a look at the source code of 
btrfs-clone,
as it contains code to walk the subvolume tree of a btrfs filesysysem.

https://github.com/mwilck/btrfs-clone/blob/master/btrfs-clone#L75


-- 
David Pottage
