Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28268174EB0
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 18:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCARYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 12:24:25 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.70]:49092 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgCARYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 12:24:24 -0500
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 12:24:23 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 5081AC1508
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2020 11:03:54 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 8S0Qjg7CiEfyq8S0Qjktmw; Sun, 01 Mar 2020 11:03:54 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CeQ4emmRWKRyDiHKUi5f7YZ129rCdlC6S417Qcy6fpQ=; b=nvSGtWx+JUibQx7oNm4ycrpIf
        QLgWCbB1E8Flf3aWraVM6W0FNnbYr/g94lQ4yJ1NNA2L5APScxUsluOZRO6/l8Ch0cVnqxI/85IkY
        YYMh2r0Vj/MfYIge3plCVX1fpS12cIJa4S17gW4mo3NbNjM/NpIsgZd1AnnYcBe0KktmTYxN9GAOt
        cKbMlreBYZQMt6rfrO6T6bHavmVzoepbe4DuIWXH/kkT2FokZlU5w6nT/Li9fAsWO6GCqET7p7q+V
        KjkbhJbr+kMJUrTpz3CC6XQAFVVODe7AllsG9SxH4jjfM44wIhBtRaPHRpGlY//Zmc9JgGV10B71J
        D+2wIkPog==;
Received: from 189.26.179.234.dynamic.adsl.gvt.net.br ([189.26.179.234]:42306 helo=hephaestus)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j8S0P-000H9I-Kl; Sun, 01 Mar 2020 14:03:54 -0300
Date:   Sun, 1 Mar 2020 14:06:54 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [ fstests PATCHv3 2/2] btrfs: Test subvolume delete --subvolid
 feature
Message-ID: <20200301170654.GA12013@hephaestus>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
 <20200224031341.27740-3-marcos@mpdesouza.com>
 <20200301134026.GK3840@desktop>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200301134026.GK3840@desktop>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.179.234
X-Source-L: No
X-Exim-ID: 1j8S0P-000H9I-Kl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.179.234.dynamic.adsl.gvt.net.br (hephaestus) [189.26.179.234]:42306
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 01, 2020 at 09:54:06PM +0800, Eryu Guan wrote:
> On Mon, Feb 24, 2020 at 12:13:41AM -0300, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Looks fine to me overall, but it'd be better to have commit message to
> describe the test.
> 
> Also, it'd be great if btrfs folks could help review it.

Indeed, a commit message makes things better. I'm attaching here a new version
of the patch containing a commit message. This new version also bumps the test
number from 203 -> 207, since other messages were merged after I sent my patch.

While adding the commit message I found in Josef's commit that he added a new
btrfs test 206, but groups contained test 204[1]. Is it a typo?

[1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=1d6d14db1165db1ffc87fbddcf97eb70fdf84607

> 
> Thanks,
> Eryu
> 
> > ---
> > Changes from v2:
> > * Added 'Created subvolume...' into 203.out to match the subvolume creating command
> > * Changed awk to $AWK_PROG, suggested by Eryu
> > * Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
> > * Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
> > * Created a local function to delete and list subvolumes, suggested by Eryu
> > 
> > Changes from v1:
> > * Added some prints printing what is being tested
> > * The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
> >   plain integers
> > 
> > 
> >  tests/btrfs/203     | 68 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/203.out | 17 ++++++++++++
> >  tests/btrfs/group   |  1 +
> >  3 files changed, 86 insertions(+)
> >  create mode 100755 tests/btrfs/203
> >  create mode 100644 tests/btrfs/203.out
> > 
> > diff --git a/tests/btrfs/203 b/tests/btrfs/203
> > new file mode 100755
> > index 00000000..0f662db1
> > --- /dev/null
> > +++ b/tests/btrfs/203
> > @@ -0,0 +1,68 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FSQA Test No. 203
> > +#
> > +# Test subvolume deletion using the subvolume id, even when the subvolume in
> > +# question is in a different mount space.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/filter.btrfs
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_btrfs_command subvolume delete --subvolid
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +
> > +_delete_and_list()
> > +{
> > +	local subvol_name="$1"
> > +	local msg="$2"
> > +
> > +	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
> > +	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
> > +
> > +	echo "$msg"
> > +	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> > +}
> > +
> > +# Test creating a normal subvolumes
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch
> > +
> > +echo "Current subvolume ids:"
> > +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> > +
> > +# Delete the subvolume subvol1, and list the remaining two subvolumes
> > +_delete_and_list subvol1 "After deleting one subvolume:"
> > +_scratch_unmount
> > +
> > +# Now we mount the subvol2, which makes subvol3 not accessible for this mount
> > +# point, but we should be able to delete it using it's subvolume id
> > +$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
> > +_delete_and_list subvol3 "Last remaining subvolume:"
> > +_scratch_unmount
> > +
> > +# now mount the rootfs
> > +_scratch_mount
> > +# Delete the subvol2
> > +_delete_and_list subvol2 "All subvolumes removed."
> > +_scratch_unmount
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
> > new file mode 100644
> > index 00000000..3301852b
> > --- /dev/null
> > +++ b/tests/btrfs/203.out
> > @@ -0,0 +1,17 @@
> > +QA output created by 203
> > +Create subvolume 'SCRATCH_MNT/subvol1'
> > +Create subvolume 'SCRATCH_MNT/subvol2'
> > +Create subvolume 'SCRATCH_MNT/subvol3'
> > +Current subvolume ids:
> > +subvol1
> > +subvol2
> > +subvol3
> > +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
> > +After deleting one subvolume:
> > +subvol2
> > +subvol3
> > +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
> > +Last remaining subvolume:
> > +subvol2
> > +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
> > +All subvolumes removed.
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index 79f85e97..e7744217 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -204,3 +204,4 @@
> >  200 auto quick send clone
> >  201 auto quick punch log
> >  202 auto quick subvol snapshot
> > +203 auto quick subvol
> > -- 
> > 2.25.0
> > 

--wRRV7LY7NUeQGEoC
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-btrfs-Test-subvolume-delete-subvolid-feature.patch"

From 2541e8ef08d45030f97073ef1e5bc9196ef22e4d Mon Sep 17 00:00:00 2001
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sun, 26 Jan 2020 23:44:22 -0300
Subject: [PATCHv4] btrfs: Test subvolume delete --subvolid feature

Now btrfs can delete subvolumes based in ther subvolume id. This makes
easy for the user willing to delete a subvolume that cannot be accessed
by the mount point, since btrfs allows to mount a specific subvolume and
hiding the other from the mount point.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes from v3:
* Changes test 203 -> 207, since other tests were merged
* The first patch was merged, so remove it from sending again
  [https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=2f9b4039253d3a6f91cb2a22639a243b5a27e110]

Changes from v2:
* Added Reviewed-by from Nikolay to patch 0001
* Changed awk to $AWK_PROG, suggested by Eryu
* Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
* Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
* Created a local function to delete and list subvolumes, suggested by Eryu

Changes from v1:
* Added some prints printing what is being tested
* The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
  plain integers
* New patch expanding the funtionality of _require_btrfs_command, which now
  check for argument of subcommands

 tests/btrfs/207     | 68 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/207.out | 17 ++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/btrfs/207
 create mode 100644 tests/btrfs/207.out

diff --git a/tests/btrfs/207 b/tests/btrfs/207
new file mode 100755
index 00000000..bec5baea
--- /dev/null
+++ b/tests/btrfs/207
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 207
+#
+# Test subvolume deletion using the subvolume id, even when the subvolume in
+# question is in a different mount space.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_btrfs_command subvolume delete --subvolid
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+_delete_and_list()
+{
+	local subvol_name="$1"
+	local msg="$2"
+
+	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
+	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
+
+	echo "$msg"
+	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
+}
+
+# Test creating a normal subvolumes
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch
+
+echo "Current subvolume ids:"
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
+
+# Delete the subvolume subvol1, and list the remaining two subvolumes
+_delete_and_list subvol1 "After deleting one subvolume:"
+_scratch_unmount
+
+# Now we mount the subvol2, which makes subvol3 not accessible for this mount
+# point, but we should be able to delete it using it's subvolume id
+$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
+_delete_and_list subvol3 "Last remaining subvolume:"
+_scratch_unmount
+
+# now mount the rootfs
+_scratch_mount
+# Delete the subvol2
+_delete_and_list subvol2 "All subvolumes removed."
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/207.out b/tests/btrfs/207.out
new file mode 100644
index 00000000..e3f7daa4
--- /dev/null
+++ b/tests/btrfs/207.out
@@ -0,0 +1,17 @@
+QA output created by 207
+Create subvolume 'SCRATCH_MNT/subvol1'
+Create subvolume 'SCRATCH_MNT/subvol2'
+Create subvolume 'SCRATCH_MNT/subvol3'
+Current subvolume ids:
+subvol1
+subvol2
+subvol3
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
+After deleting one subvolume:
+subvol2
+subvol3
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
+Last remaining subvolume:
+subvol2
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
+All subvolumes removed.
diff --git a/tests/btrfs/group b/tests/btrfs/group
index e3ad347b..1acf6af7 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -209,3 +209,4 @@
 204 auto quick punch
 205 auto quick clone compress
 204 auto quick log replay
+207 auto quick subvol
-- 
2.25.0


--wRRV7LY7NUeQGEoC--
