Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839CB500C3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242359AbiDNLj6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 07:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiDNLj5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 07:39:57 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 04:37:33 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A15005C
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 04:37:33 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1nexiA-0007QM-9x
        for linux-btrfs@vger.kernel.org; Thu, 14 Apr 2022 13:32:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Andrew Skretvedt <andrew.skretvedt@gmail.com>
Subject: Re: what mens gen and ogen in btrfs sub list / ?
Date:   Thu, 14 Apr 2022 06:32:22 -0500
Message-ID: <t390o7$r7k$1@ciao.gmane.io>
References: <587892959.1863318.1648125512532.JavaMail.zimbra@helmholtz-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <587892959.1863318.1648125512532.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Language: en-US
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_20,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, basic btrfs user and enthusiast here. I have a reaction, seeing
as none of the experts here have so far replied,

On 3/24/22 7:38 AM, Lentes, Bernd wrote:
> I read the manpage and stumbled across gen and ogen of snapshots.
> But what does that mean and how can the values be interpreted ?
> Or is there another way to list the snapshots by e.g. creation date ?

I'm going by the manpages,

I don't claim to understand the concept of "generation" with respect to
subvolumes, but I've noted that it seems to be something that
continually increases as you use a btrfs filesystem. In doing some tests
today, I find that when I create a new subvolume inside another, the gen
of the containing subvolume and the newly created subvolume increase to
a new, larger value in common to both, and that the cgen (someone can
say how cgen and ogen relate, the manpage doesn't mention cgen, while
the tools report it, and it seems like cgen is a new name for ogen) on
the newly created subvolume is the value the containing subvolume gen
had before the new subvolume was created.

So, these values don't seem to me to be what you'd want to track.

> i'd like to write a script in which, beneath other stuff, the oldest snapshot(s) are deleted.
> So i'm looking for a way to sort the list of the snapshots by date.

Here, the rootids are closer to what you want. These also increase with
each new subvolume created. Newer snapshots will have higher IDs than
older ones. Also the 'btrfs subvolume list' command has an option to
list out only /snapshots/, as opposed to subvolumes which weren't
created as a result of a snapshot operation. With such a list, you could
select from the list of snapshot subvolumes, those with lower IDs for
candidate deletion.

I also found in the manpage that 'btrfs subvolume show' will display
extra info that isn't listed in 'btrfs subvolume list', among which is
the subvolume's creation date. It would be a more complicated script,
but issuing 'show' commands on the snapshots reported in the 'list'
command would allow you to build up a list of creation dates for each
snapshot. Then, you could issue 'delete' commands according to some
date-based criterion set by your script.

I don't know if another way to reveal the creation dates of snapshot
subvolumes, but if another method exists, I leave it to others to point out.

In my own use of btrfs subvolumes and snapshotting, I name snapshot
subvolumes using a date-based name scheme, so the subvolume path
implicitly also reveals the date of the snapshot's creation. I also
enjoy the 'send'/'receive' features of btrfs, and I find myself paying
the most attention to the various UUIDs that subvolumes may have. This
allows me to track which parent subvolume UUID a snapshot is created
from, as well as what subvolume a sent/received subvolume relates to.
The UUID scheme btrfs subvolumes use really seems clever, to me. I've
used it to great success in sending incremental changes efficiently to
backup storage, as a given reference subvolume is repeatedly snapshot.

Hope that gives you some insight.

-A

-- 
OpenPGP 0xC6901B2A6C976BB3 (https://keys.openpgp.org)

