Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A1642983
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 14:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiLENiE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 5 Dec 2022 08:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiLENhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 08:37:52 -0500
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 05:37:48 PST
Received: from novaprospekt.domainmess.org (novaprospekt.domainmess.org [185.142.180.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4F8959C
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 05:37:46 -0800 (PST)
MIME-Version: 1.0
Date:   Mon, 05 Dec 2022 13:28:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
From:   benibr@domainmess.org
Message-ID: <a3c94f14eb13667ff5dba3cb9455b875@domainmess.org>
Subject: Feature Request: Subvolume Expiration
To:     linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone,

I'd like to propose "subvolume expiration dates" as a new feature for btrfs.

I want to use btrfs for archiving and backup solutions for which snapshots are very convenient.
However, the rotation and cleanup of snapshots is always based on some scripting and often
reimplemented for each usecase.
I know at least some proprietary storage solutions which allow to set a expiration date on
snapshots so I wonder if it would be possible to add a similar functionality to btrfs.
The advantage would be that one doesn't have to encode the expiry information in the subvolume name
or parse it from an extended file attribute but it would be an (optional) attribute of the
subvolume itself.
Therefore it would be easy to implement a subcommand in btrfs-progs which checks for expired
subvolumes and deletes them (eg. `btrfs subvolume prune` or similar).
This would make btrfs a very easy to use solution for archiving data for a specific timespan as
well as for backup snapshot rotations.

As I understand it I'd say the expiration date could be implemented in the `root_item` struct by
squeezing in a additional `btrfs_timespec` into the `reserved` space.
But since I'm not really familiar with btrfs code I wanted to ask for more opinions before I spend
time on a proof-of-concept.

So is this feature interesting, absurd, nice to have or completely impossible?
Any feedback welcome :-)

Regards,
Beni
