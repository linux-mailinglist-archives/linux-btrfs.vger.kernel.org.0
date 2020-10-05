Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8228337E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJEJkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 05:40:05 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:36560
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEJkF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 05:40:05 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 05:40:04 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1kPMta-00082h-Ch
        for linux-btrfs@vger.kernel.org; Mon, 05 Oct 2020 11:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-btrfs@vger.kernel.org
To:     linux-btrfs@vger.kernel.org
From:   Torsten Bronger <bronger@physik.rwth-aachen.de>
Subject: Why so much "btrfs send" data for "cp -a --reflink"?
Date:   Mon, 05 Oct 2020 09:54:40 +0200
Organization: Phoenix Foundation
Message-ID: <87362t3y67.fsf@physik.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:yiV8+JuAGG8JLV2V8WYl8uFGhe4=
X-PGP-Fingerprint: C5C8 D6E2 79D2 EFE9 8C0F  6D77 D5E3 CEFC 9F51 6B77
X-PGP-Affinity: will accept encrypted message for GPG
X-Home-Page: http://www.wikipedia.org/wiki/User:Bronger
X-Face: +wpw"|jN2Fde|7<r"A\7[g0RGE#"N'WgB|46ohZy$RfV+Y!oH=FKMC>_<EQ_IdY;pJcjJrx
 {m$r$vTG>lKBa0\7!_6<ouwhB1|a+k#?z597ims{Y+POGr7Z{,b]wj]6Z"PqUHzA2\|m(:>suIE_m!
 x)'S9ytBu8tkt'k779jbzQ4o|p+@H_DCrIdnKG]E*w
X-Binford: 6100 (more power)
X-Accept-Language: de, en
Jabber-ID: torsten.bronger@jabber.rwth-aachen.de
Mail-Copies-To: never
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hallöchen!

I have two subvolumes A and B.  „A“ contains 50GB data, B is empty.
None is a snapshot of the other.  Now, I copy all data from A to B
with "cp -a --reflink A/* B".  This copying takes less than a
second.  So apparently, no bulk data was duplicated.  "diff -rq A B"
is empty.  So far, so good.

However, it surprises me that

    btrfs send -p A B | wc -c

reports 12GB.  I would have hoped for very few data (say, a couple
of MBs).  Or, the whole 50GB (because A is not a real parent of B,
and never has been).  An additional "-c A" does not change anything.

Why is this?  In other words, what comprises those 12GB?

It may be insignificant, but the 50GB are almost fully a single
VirtualBox .vdi file, somewhat fragmented (filefrag says 16000).

Regards,
Torsten.

-- 
Torsten Bronger

