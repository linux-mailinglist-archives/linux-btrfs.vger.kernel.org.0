Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3117B4FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 04:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFDgV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 22:36:21 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.60]:28023 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgCFDgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 22:36:20 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 2BFA7AC17
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2020 21:36:19 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id A3mdj9KRNRP4zA3mdjWWpF; Thu, 05 Mar 2020 21:36:19 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZIqXbAwULCj9TuWR2cBPDNb3y0cMpsb8eA23RioXHJw=; b=KMKUqRuTpQtaU0dGfb0MA02cP
        eDwq0/wQfw4W9IEU/IEV3XQ7NgS2nr2SQFmkrjOtoIkZOMjKitIAbFMjzADN0DFgf3AdH7FufVCqz
        BnxicidK6My1BIY9lY1ZReO9PzJlftdGOrplMX+7Vwgos2RDxTnPnN+JjXhc354Cl+rE0uHeGE7V1
        mcz7gt/jhchkmIvYkJkNT754iKHBtWN8SYf2/TMAwumt84Yk3va57qVINFXKqLUQzeaVhqtCb2VCM
        Ait1CuJ93fSRaS1INYccpxWYEDBET98MbRWqok7Qm4ii+1QAyCzkkDaFWlyLOIJuu/4CscMPVnapx
        Xn4eOXt/g==;
Received: from 189.26.184.111.dynamic.adsl.gvt.net.br ([189.26.184.111]:43290 helo=hephaestus)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jA3mc-0027Kv-Js; Fri, 06 Mar 2020 00:36:18 -0300
Date:   Fri, 6 Mar 2020 00:39:22 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        wqu@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] progs: mkfs-tests: Skip test if truncate failed with
 EFBIG
Message-ID: <20200306033922.GA32710@hephaestus>
References: <20200224180534.15279-1-marcos@mpdesouza.com>
 <20200302200716.GW2902@twin.jikos.cz>
 <20200302203006.GA22707@hephaestus>
 <20200302203649.GA2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20200302203649.GA2902@twin.jikos.cz>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.184.111
X-Source-L: No
X-Exim-ID: 1jA3mc-0027Kv-Js
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.184.111.dynamic.adsl.gvt.net.br (hephaestus) [189.26.184.111]:43290
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2020 at 09:36:49PM +0100, David Sterba wrote:
> On Mon, Mar 02, 2020 at 05:30:06PM -0300, Marcos Paulo de Souza wrote:
>
> > >From 52b96ac75c2f8876f1ed9424cef92a4557306009 Mon Sep 17 00:00:00 2001
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > Date: Sat, 15 Feb 2020 19:47:12 -0300
> > Subject: [PATCH] progs: mkfs-tests: Skip test if truncate failed with EFBIG
> > 
> > The truncate command can fail in some platform like PPC32[1] because it
> > can't create files up to 6E in size. Skip the test if this was the
> > problem why truncate failed.
> > 
> > [1]: https://github.com/kdave/btrfs-progs/issues/192
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  tests/mkfs-tests/018-multidevice-overflow/test.sh | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> > index 6c2f4dba..b8e2b18d 100755
> > --- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
> > +++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> > @@ -14,7 +14,17 @@ prepare_test_dev
> >  run_check_mkfs_test_dev
> >  run_check_mount_test_dev
> >  
> > -run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
> > +# truncate can fail with EFBIG if the OS cannot created a 6E file
> > +stdout=$($SUDO_HELPER truncate -s 6E "$TEST_MNT/img1" 2>&1)
> 
> So this is reading and parsing stdout, but not using the standard
> helpers that also log the commands. The stdout approach probably works
> but I'd still like to avoid using plain $(...)

What do you think about the patches bellow? With these two patches applied you
can drop this one. Thanks.

--k1lZvvs/B4yU6o8G
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: inline;
	filename="0001-btrfs-progs-tests-common-Introduce-run_mayfail_stdou.patch"

From f54ec71fa4e6c4153a57d519b3524300946cd8b8 Mon Sep 17 00:00:00 2001
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 5 Mar 2020 23:57:52 -0300
Subject: [PATCH 1/2] btrfs-progs: tests: common: Introduce run_mayfail_stdout

This helper would help to run tests that can fail, but depending on the
output of the error we can skip the test instead of failing.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/common | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/common b/tests/common
index f5efc58b..2f698e08 100644
--- a/tests/common
+++ b/tests/common
@@ -216,6 +216,37 @@ run_mayfail()
 	fi
 }
 
+# same as run_mayfail but prints the error message to stdout too
+run_mayfail_stdout()
+{
+	local spec
+	local ins
+	local ret
+
+	ins=$(_get_spec_ins "$@")
+	spec=$(($ins-1))
+	spec=$(_cmd_spec "${@:$spec}")
+	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
+	echo "====== RUN MAYFAIL $@" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mayfail): $@" > /dev/tty; fi
+
+	if [ "$1" = 'root_helper' ]; then
+		"$@" 2>&1 | tee -a "$RESULTS"
+	else
+		$INSTRUMENT "$@" 2>&1 | tee -a "$RESULTS"
+	fi
+	ret=${PIPESTATUS[0]}
+	if [ $ret != 0 ]; then
+		echo "failed (ignored, ret=$ret): $@" >> "$RESULTS"
+		if [ $ret == 139 ]; then
+			_fail "mayfail: returned code 139 (SEGFAULT), not ignored"
+		elif [ $ret == 134 ]; then
+			_fail "mayfail: returned code 134 (SIGABRT), not ignored"
+		fi
+		return $ret
+	fi
+}
+
 # first argument is error message to print if it fails, otherwise
 # same as run_check but expects the command to fail, output is logged
 run_mustfail()
-- 
2.25.0


--k1lZvvs/B4yU6o8G
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: inline;
	filename="0002-progs-mkfs-tests-018-Skip-test-if-truncate-failed-wi.patch"

From 085708404477cbb40d1c6b43f4a59d9611e5eddc Mon Sep 17 00:00:00 2001
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 15 Feb 2020 19:47:12 -0300
Subject: [PATCH 2/2] progs: mkfs-tests: 018: Skip test if truncate failed with
 EFBIG

The truncate command can fail in some platform like PPC32[1] because it
can't create files up to 6E in size. Skip the test if this was the
problem why truncate failed.

[1]: https://github.com/kdave/btrfs-progs/issues/192

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/018-multidevice-overflow/test.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
index 6c2f4dba..23c0b634 100755
--- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
+++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
@@ -14,7 +14,18 @@ prepare_test_dev
 run_check_mkfs_test_dev
 run_check_mount_test_dev
 
-run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
+# truncate can fail with EFBIG if the OS cannot created a 6E file
+stdout=$(run_mayfail_stdout $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1" 2>&1)
+ret=$?
+
+if [ $ret -ne 0 ]; then
+	run_check_umount_test_dev
+	if [[ $stdout == *"File too large"* ]]; then
+		_not_run "Current kernel could not create a 6E file"
+	fi
+	_fail "Command failed: $stdout"
+fi
+
 run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img2"
 run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img3"
 
-- 
2.25.0


--k1lZvvs/B4yU6o8G--
