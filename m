Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27C8485B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfHGJE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 05:04:28 -0400
Received: from savella.carfax.org.uk ([85.119.84.138]:44814 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfHGJE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 05:04:28 -0400
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1hvHru-0004if-O7; Wed, 07 Aug 2019 10:04:26 +0100
Date:   Wed, 7 Aug 2019 10:04:26 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Jon Ander MB <jonandermonleon@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unable to delete or change ro flag on subvolume/snapshot
Message-ID: <20190807090426.GH24125@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Jon Ander MB <jonandermonleon@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CACa3q1zdz9XHGzkrhyfACo58iRBWMRGPzbQTebaN3aU0HLJxgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACa3q1zdz9XHGzkrhyfACo58iRBWMRGPzbQTebaN3aU0HLJxgw@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 10:37:43AM +0200, Jon Ander MB wrote:
> Hi!
> I have a snapshot with the read only flag set and I'm currently unable
> to delete it or change the ro setting
> btrfs property set -ts /path/t/snapshot ro false
> ERROR: failed to set flags for /path/t/snapshot: Operation not permitted
> 
> Deleting the snapshot is also a no-go:
> 
> btrfs subvolume delete /path/t/snapshot
> Delete subvolume (no-commit): '/path/t/snapshot'
> ERROR: cannot delete '/path/t/snapshot': Operation not permitted

   First question: are you running those commands as root?

   Second question: has the FS itself gone read-only for some reason?
(e.g. corruption detected).

   Hugo.

> 
> The snapshot information:
> 
> btrfs subvolume show /path/t/snapshot
> /path/t/snapshot
>         Name:                   snapshot
>         UUID:                   66a145da-a20d-a44e-bb7a-3535da400f5d
>         Parent UUID:            f1866638-f77f-e34e-880d-e2e3bec1c88b
>         Received UUID:          66a145da-a20d-a44e-bb7a-3535da400f5d
>         Creation time:          2019-07-31 12:00:30 +0200
>         Subvolume ID:           23786
>         Generation:             1856068
>         Gen at creation:        1840490
>         Parent ID:              517
>         Top level ID:           517
>         Flags:                  readonly
>         Snapshot(s):
> 
> 
> Any idea of what can I do?
> 
> Regards!
> 

-- 
Hugo Mills             | I'm all for giving people enough rope to shoot
hugo@... carfax.org.uk | themselves in the foot.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                        Andreas Dilger
