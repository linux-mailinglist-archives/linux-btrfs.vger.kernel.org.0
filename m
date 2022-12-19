Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BF6516D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 00:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiLSXtX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 18:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiLSXtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 18:49:22 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C113F62EF
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Dec 2022 15:49:21 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BJNn9S2000724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671493751; bh=8gBSicQYVSkXq4MLDfSbUqlg8dc9NtQwKga0LQZa9gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IFvE+YbDQTzMvSGfHVTehC2VUIPjgwIbmDxLZIrGHYtVy+W55gPKrv8cwO5/t2qTu
         HthMzHfDR3/PdQqVJ0dAXFXZzojwrnomvuNfCLkGXNj7aTPIDZCbmSVci2qhggvx2t
         vQLk1i9ArAYZLdZAFO5PjpZ5XjQQdWpPoD8VF+X6QFeZpJq2Eu3F0RJ8Zcsr1t126n
         1C7EoC851x13ecpnM6098qRWXbHZOgK+WXwOSCCI5Y3x0T7Sb08U0fOkqZHGd4wZrv
         NLpcOzBjZ0mkIrVG1orLrmgWQHy8AodEf1vkmk5L2h/VxblTpikVoOLlfIp8Y8WqVN
         PTR+skPGOqGTg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5C47015C3511; Mon, 19 Dec 2022 18:49:09 -0500 (EST)
Date:   Mon, 19 Dec 2022 18:49:09 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: report: always save the dmesg as system-err if
 KEEP_DMESG is set
Message-ID: <Y6D4dUS0Idb2XGYJ@mit.edu>
References: <20221216065121.30181-1-wqu@suse.com>
 <Y6Ch1Qq9op2tmB1U@magnolia>
 <Y6Cz+trxF6JtubwN@mit.edu>
 <97c625a9-3b5a-c3ae-d69f-cfb71266cd30@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c625a9-3b5a-c3ae-d69f-cfb71266cd30@gmx.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 06:45:27AM +0800, Qu Wenruo wrote:
> 
> 
> On the other hand, separating dmesg from its test cases means extra parsing
> to bind the log section to certain test runs.
> 
> In fact, I'm not even sure if possible to do that.
> E.g. on the same host with different kernel/fstests configs.

Well, I just have my test runner framework drop a file which contains
a single line[2] in the /etc/rsyslog.d directory, and then kill -HUP
rsyslogd.  When I'm done, I'll reconfigure rsyslog and HUP it again,
and then tar up the results directory, and save that as part of my
test artifacts for that particular test run.

[2]   *.*;auth,authpriv.none		-/results/syslog

(This could probably be "kern.*" instead, but occasionally it's useful
to see what other kind of background noise might be running on the
test machine that might be disturbing the test run.)

The /results directory will contain a copy of the current kernel's
build config file, the arguments to the xfstests run, the xfstests
results directory with all of the NNN.full and NNN.out.bad files, and
of course, the syslog file.  I also have things like a copy of
/proc/slabinfo before and after the run; and I have support for hook
scripts that can enable/disable ftrace with various tracepoints and
which will drop the ftrace logs in the /results directory.  (I don't
have support for drgn or BPF scripts yet, but one of these days...)

Anyway, my test framework will compress the /results directory and
save it away (in my case, in Google Cloud Store).  For a full ext4
test run (twelve "-g auto" runs with different fs configs), the
compressed test artifact tarball will be about 23 megabytes.  In
contrast, the xunut-quiet XML file will be about 80k compressed, and
the test run summary which lands in my e-mail inbox is less than 4k. :-)

	      	       	  	 - Ted

P.S.  This is a recent test run on btrfs using my test environment.
I'm curious whether any of these test failures look familiar to you.
(Some of them may very well be issues in how I set up the btrfs pool
of block devices, which is a relatively new feature in gce-xfstests.
What are you seeing when you run -g auto on btrfs using the default
file system config?)

TESTRUNID: tytso-20221212170803
KERNEL:    kernel 6.1.0-xfstests #2 SMP PREEMPT_DYNAMIC Mon Dec 12 16:09:40 EST 2022 x86_64
CMDLINE:   -c btrfs/4k -g auto
CPUS:      2
MEM:       7680

btrfs/4k: 953 tests, 21 failures, 176 skipped, 12135 seconds
  Failures: btrfs/006 btrfs/012 btrfs/049 btrfs/100 btrfs/162 btrfs/163
    btrfs/184 btrfs/192 btrfs/196 btrfs/197 btrfs/218 btrfs/219 btrfs/235
    btrfs/254 btrfs/277 btrfs/291 generic/455 generic/457
  Flaky: btrfs/028: 40% (2/5)   generic/475: 60% (3/5)
    shared/298: 20% (1/5)

FSTESTIMG: gce-xfstests/xfstests-amd64-202211301035
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 068bd2a (Fri, 18 Nov 2022 08:38:35 +0900)  
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5 (Sun, 6 Feb 2022 10:59:13 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-52-gf7e24ee (Tue, 1 Nov 2022 11:45:06 +0100)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200) 
FSTESTVER: xfsprogs v6.0.0 (Mon, 14 Nov 2022 12:06:23 +0100)   
FSTESTVER: xfstests-bld 920c0e32 (Mon, 28 Nov 2022 00:37:48 -0500)
FSTESTVER: xfstests v2022.11.27-8-g3c178050c (Wed, 30 Nov 2022 10:25:39 -0500)
FSTESTVER: zz_build-distro bullseye
FSTESTCFG: btrfs/4k
FSTESTSET: -g auto
FSTESTOPT: aex
GCE ID:    1186623270044702885


					- Ted
