Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4420A92
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfEPPCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 11:02:48 -0400
Received: from tty0.vserver.softronics.ch ([91.214.169.36]:39732 "EHLO
        fe1.digint.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEPPCr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 11:02:47 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 11:02:46 EDT
Received: from [10.0.1.10] (unknown [81.6.39.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by fe1.digint.ch (Postfix) with ESMTPSA id 670FB30C26
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 16:54:55 +0200 (CEST)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Axel Burri <axel@tty0.ch>
Subject: Used disk size of a received subvolume?
Openpgp: preference=signencrypt
Autocrypt: addr=axel@tty0.ch; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
Date:   Thu, 16 May 2019 16:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Trying to get the size of a subvolume created using "btrfs receive",
I've come with a cute little script:

   SUBVOL=/path/to/subvolume
   CGEN=$(btrfs subvolume show "$SUBVOL" \
     | sed -n 's/\s*Gen at creation:\s*//p')
   btrfs subvolume find-new "$SUBVOL" $((CGEN+1)) \
     | cut -d' ' -f7 \
     | tr '\n' '+' \
     | sed 's/\+\+$/\n/' \
     | bc

This simply sums up the "len" field from all modified files since the
creation of the subvolume. Works fine, as btrfs-receive first makes a
snapshot of the parent subvolume, then adds the files according to the
send-stream.

Now this rises some questions:

1. How accurate is this? AFAIK "btrfs find-new" prints real length, not
compressed length.

2. If there are clone-sources in the send-stream, the cloned files
probably also appear in the list.

3. Is there a better way? It would be nice to have a btrfs command for
this. It would be straight-forward to have a "--summary" option in
"btrfs find-new", another approach would be to calculate and dump the
size in either "btrfs send" or "btrfs receive".

Any thoughts? I'm willing to implement such a feature in btrfs-progs if
this sounds reasonable to you.


- Axel


Ref: https://github.com/digint/btrbk/issues/280
