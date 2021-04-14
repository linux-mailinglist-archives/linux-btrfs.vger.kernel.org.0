Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3428635F1D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhDNK7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346548AbhDNK7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 06:59:35 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE1C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 03:59:13 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 5C47C9C271; Wed, 14 Apr 2021 11:59:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1618397948;
        bh=mzNP65eSu4IMIDEP6D5o0Fd2MAFwbvBUr0kSCo9ZESM=;
        h=To:From:Subject:Date:From;
        b=tD4DS4tkXl/NVsZIt5wUBprWlEaP5DAtuIi8e9hrRnYsSEfcxqsDWJ03KqzL9Jkd0
         Sch5TRDhATMfs+hBQQ1jqJUBrH0WK3uOu2G2KDTGr8Cz2DFVcrITBQYxPlZdmCUATE
         IrrBXhQc3bQ5Jwey4W7V/cgN2+6pjqLk9/yeANvCtqSbDMfbSuX8S5+ftOo72jSKiK
         GtbImAoo6x9rlMM3NUq9VzzC/cJydH0526hIkqm2iJtEw0QM0Jd+bWLzdYAUc3KQgd
         9BclJHSdIqhsmRf2blsq8BYQZxRjlbE1WTNXFI6L+cRGCTucm+uNZxb4EQLQTlnzac
         rTRK6hnH9Z9/w==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id A7C359BBE6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 11:59:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1618397944;
        bh=mzNP65eSu4IMIDEP6D5o0Fd2MAFwbvBUr0kSCo9ZESM=;
        h=To:From:Subject:Date:From;
        b=qoSGaGVQkRsrbTDDhpt211/30Y50w4aeXLolonjpp5UGID9RP+Mb0l0v1CcJQRhrW
         cbgWdywKAvxDFcWA6ct/lgeYVCp12V5C9DkD2X61qPN3mKSFkFYsRduCtMBGPzoFzE
         xi4CEiGVGaFSxr2mMk8v1AvvXTX8D+NDBOtsoYHRDuOTRwlS6NrLPpMk3SRWMq6PmB
         dw65TgXIzdKu/GxDhCW36BLmfl1fdNO2huBqMRKNdiYhJ82BghwiMiZi7uroQZr92C
         2pz9hRuWuCkdwh1lHTJjtcAWzYIexBp8rWaigzJ415cdQ+2AHdjWFzFHRxuneknjxE
         Vt8M2erosSb3Q==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 3529122844B
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 11:59:04 +0100 (BST)
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: btrfs-progs top-level options man pages and usage
Message-ID: <704ae072-1b0e-c146-f92e-4e58d53bcc1e@cobb.uk.net>
Date:   Wed, 14 Apr 2021 11:59:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I have a cron job which frequently deletes a subvolume and I decided I
wanted to silence the output. I remembered there was a -q option and
thought I would just quickly glance at the documentation for it to check
there wasn't some reason I had not put that in the script when I first
wrote it some time ago.

That opened up an Alice-in-Wonderland rabbit hole... the documentation
for the common command options in btrfs-progs is not just awful, I ended
up very confused about what I was seeing...

There are several issues:

1) The man pages do not describe the top-level btrfs command options, or
their equivalents at subcommand level.

1a) btrfs.asciidoc makes no mention of -q, --quiet, -v, --verbose or
even of the concept of top-level btrfs command options. It just explains
how the subcommand structure works.

1b) btrfs-subvolume.asciidoc makes no mention of -q or --quiet. However,
it *does* mention -v and --verbose but with the completely cryptic (if
you are not a btrfs-progs developer) description "(deprecated) alias for
global '-v' option". What global '-v' option is that then as it is not
documented in btrfs.asciidoc? And what about '-q'?

I haven't looked at the other subcommand pages.

2) The built-in help in btrfs and btrfs-subvolume do not describe the
top level command options.

2a) 'btrfs' shows a usage message that shows the -q, --quiet, -v and
--verbose options but with no information on them. 'btrfs --help'
provides no further information. 'btrfs --help --full' does, but it is
almost 800 lines long.

2b) 'btrfs subvolume' doesn't even mention these options in its usage
message. Nor does it mention the --help option or the --help --full
option as global options or as subcommand options. 'btrfs subvolume
--help' provides exactly the same output. 'btrfs subvolume --help
--full' does at least mention the options - if anyone can ever guess
that it exists.

Again, I haven't looked at the other subcommands.

3) The difference between global options and subcommand options is very
unfortunate, and very confusing. I *hate* the concept of global options
(as implemented) -- in my mental model the 'btrfs' command is really
just a prefix to group together various btrfs-related commands and I
don't even *think* about ever inserting an option between btrfs and the
subcommand. In my mental model, the command is 'btrfs subvolume'. In my
mind, if the command was 'btrfs' then the syntax would more naturally be
'btrfs create subvolume' (like 'Siri, call David') instead of 'btrfs
subvolume create'.

3a) One particularly unfortunate effect is that 'btrfs subv del -v XXX'
works but 'btrfs subv del -q XXX' does not. I consider myself very
experienced with btrfs but even after drafting the first version of this
email I changed my script to do this and was surprised when it didn't work.

3b) Another confusing effect is that both 'btrfs -v subv del XXX' and
'btrfs subv del -v XXX' work but 'btrfs subv -v del XXX' does not.

I think fixing the man page to document the global options is important
and I am happy to try to create a suitable patch. Does anyone else feel
the other issues should be fixed?

Graham
