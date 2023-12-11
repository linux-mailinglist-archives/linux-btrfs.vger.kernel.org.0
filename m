Return-Path: <linux-btrfs+bounces-820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC93D80DB93
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 21:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50775B21666
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194D53E1B;
	Mon, 11 Dec 2023 20:26:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309CD98
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 12:26:41 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6AA1D819EB
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 20:26:40 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id B3F488071D
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 20:26:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702326400; a=rsa-sha256;
	cv=none;
	b=xuaZQ7IhK5Y1IXwX1cnAuMPY+QNGttLfpzdlwNg3Ck3DR7se3XQaAZpxMuvPMKzxz8f7Kf
	sqrSDR2SLCnn9st1PKjKRO1colJU3V6kYXn/7BkDDo0NwE5ubsDpU9SjFZkB8n6n88z1Qp
	ZiFUiQdW4YUbCZ8F0B8MCb8dTMy43zpQeeEaNjg3kK5YqZrrzhFzhpSTkGy+CU28TNRia7
	5Ky1P6iaoyFDUW/Zo9v9NU2kBIWHVfsaUXRjzMrZonpADHVy6Wt4Vj+xcFbDN1fQ7EI1fx
	iHSM0ZTMNhoxm17mtDlU/5JEgAlgpVBV88qnIroPZcFKMLt0aAju1PIYaUejQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702326400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sfn7aQ/AH6IL0frayFan9CTZniRC16bXIs01Lf+JPYE=;
	b=WEN6qbQd+j4fdhdr2vFG0yHNirD1iSp3BOW21FioFKZzsGDlRVzDS/3OYnUUc1EVnQpFpW
	+IfYlu67VpcTbxJKl+lSqYlDFSPWiPMhFphUE6Ac3OtJ2KrMsujF7aCd6zuTVFZs46fvn5
	V0bQpiaAhRmYBIazU8kelqGBSmBQDXKsSv33x5TFUTPX57N7Lsgw1KAKQD+FPvdbbWRYdL
	yM/Ve9daHcqD3r2SerP6r5X+b2jccf8EdtuKhhY+dGn2GnpoAi8sDB1HYDD0RGNyeDuad2
	N59LyrXYjV2avHbEaE8RZYvHWYoNIYDBz/QHwSoK/c9Bqv6ifg3JyCUkd+iu5w==
ARC-Authentication-Results: i=1;
	rspamd-6cb9686b59-krj97;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bored-Average: 196c7a7d60cf74cc_1702326400137_3554575037
X-MC-Loop-Signature: 1702326400137:2573157049
X-MC-Ingress-Time: 1702326400137
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.127.7.218 (trex/6.9.2);
	Mon, 11 Dec 2023 20:26:40 +0000
Received: from p5090f0e4.dip0.t-ipconnect.de ([80.144.240.228]:55002 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rCmrK-00058Y-0g
	for linux-btrfs@vger.kernel.org;
	Mon, 11 Dec 2023 20:26:38 +0000
Message-ID: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
Subject: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs@vger.kernel.org
Date: Mon, 11 Dec 2023 21:26:32 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

I think the following might have already happened the 2nd time. I have
a Debian stable with kernel 6.1.55 running Prometheus.

There's one separate btrfs, just for Prometheus time series database.


# btrfs check /dev/vdb=20
Opening filesystem to check...
Checking filesystem on /dev/vdb
UUID: decdc81d-7cc4-431c-ab84-e03771f6de5d
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 42427637760 bytes used, no error found
total csum bytes: 27362284
total tree bytes: 32686080
total fs tree bytes: 1982464
total extent tree bytes: 360448
btree space waste bytes: 2839648
file data blocks allocated: 54877196288
 referenced 28014796800
# mount /data/main/


# df | grep main
/dev/vdb       btrfs      43G   43G   25k 100% /data/main

=3D> df thinks it's full


# btrfs filesystem usage /data/main/
Overall:
    Device size:		  40.00GiB
    Device allocated:		  40.00GiB
    Device unallocated:		   1.00MiB
    Device missing:		     0.00B
    Device slack:		     0.00B
    Used:			  39.54GiB
    Free (estimated):		  24.00KiB	(min: 24.00KiB)
    Free (statfs, df):		  24.00KiB
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		  29.22MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,single: Size:39.48GiB, Used:39.48GiB (100.00%)
   /dev/vdb	  39.48GiB

Metadata,DUP: Size:256.00MiB, Used:31.16MiB (12.17%)
   /dev/vdb	 512.00MiB

System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
   /dev/vdb	  16.00MiB

Unallocated:
   /dev/vdb	   1.00MiB

=3D> btrfs does so, too

# btrfs subvolume list -pagu /data/main/
ID 257 gen 2347947 parent 5 top level 5 uuid ae3fa7ff-f5a4-cf44-8555-ad5791=
95036c path <FS_TREE>/data

=3D> no snapshots involved

# du --apparent-size --total -s --si /data/main/
29G	/data/main/
29G	total

=3D> but when actually counting the file sizes, there should be 11G left.


:/data/main/prometheus# dd if=3D/dev/zero of=3Dfoo bs=3D1M count=3D1
dd: error writing 'foo': No space left on device
1+0 records in
0+0 records out
0 bytes copied, 0,0876783 s, 0,0 kB/s


And it really is full.


Any ideas how this can happen?


Thanks,
Chris.

