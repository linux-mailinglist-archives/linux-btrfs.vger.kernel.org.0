Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93B35EEBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 09:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhDNHtw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 03:49:52 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:37917 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232940AbhDNHtv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 03:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618386569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u8bjVzxFIQhFUZ9pLUhtd9MpUqYckYN/FoONsOqbNlM=;
        b=mNzN5MMykswjSAvS7nk2qrTCPTv6ozncdoo8b9lHA27rsxc7TjlfQLghndlt+dx4g3FbXi
        VcAsGwhfOLOrL7CLlRHebLtXArNeUHx8uWM+9mGBmsD0Hz0ZKElRy684mVQadu2wawX78o
        kZaYDp16MaQG5K0TRWoUaJmmE+iLeNQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-1FH4MhN2MTGjeJ1IYeHQoQ-1; Wed, 14 Apr 2021 09:49:28 +0200
X-MC-Unique: 1FH4MhN2MTGjeJ1IYeHQoQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAugkCWoU39hiocAlu1evJugtNMrya7+g0o238+oLu5d15b4znmH+P7huJXK1AX9UFjXYSVXMgZs1ifXDLbSQDCWEcqy6rRYHr1Fedc1atTtoY5C7Mgbvko+QRDUbah18PK4mXr3A8xNJoN5DRoGrjZ7VD5nezXYmHBp1yth+JZVvE3bK55yE9iFyUd86/kcJRKJpadR1gKb7rzEhjCoLz2KYH0gst4MtQ2ip1+Au3yq51kd7z2VSYd+lJqgUqTLyWlGeWubpoxk7JUG4MtebLsTE5sC7k0AibgfOTIB0CgssqJB1rgI18+6ebcSYlM9hsjN9JiiNca+cNqCXPcrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/PjstyKeP8A8DxzMOXJ63Xcx97jUe7AHaVzdIQjRnU=;
 b=EJErPm1K98RPt6iBxTRA0JDn/pydbSEzyNDQhEyCRctNB8CR3OtMLM/QsPnYmDmpwJFeRlbnqoJ6Iwh/pSAltyWxXUhQeHyJDldzTq4Vyna+ekIpvl31vrq/Trbn8ilhktbSWnlDJk9qRJm0UwdWN1NgwUe8Ic2c0XYqDks25E/yciecRhALj9btxN+nRA5md6n7cC0iOmeDIEmXnUihfijFcMglirW3wvdthdw+Bla1t2mnx5GwYC2uq949bv4wx93PCi0BvOVSvlRiat4RSnoyuYCRB/SWVI6RSIUVMYsgmSJcVQuA1qPN9zCG7plzZrp9mOGMcbiCPgU1YSHH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4215.eurprd04.prod.outlook.com (2603:10a6:209:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 07:49:26 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::89d0:f959:1d33:55e7]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::89d0:f959:1d33:55e7%7]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 07:49:26 +0000
From:   An Long <lan@suse.com>
To:     linux-btrfs@vger.kernel.org
CC:     An Long <lan@suse.com>
Subject: [PATCH] btrfs-progs: tests: add misc test for enqueue parameter
Date:   Wed, 14 Apr 2021 15:49:06 +0800
Message-ID: <20210414074906.17715-1-lan@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [222.129.56.156]
X-ClientProxiedBy: HKAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:d0::17) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (222.129.56.156) by HKAPR04CA0007.apcprd04.prod.outlook.com (2603:1096:203:d0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 07:49:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c048fca-5a89-43de-74ac-08d8ff19d3bf
X-MS-TrafficTypeDiagnostic: AM6PR04MB4215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4215AC6169269BECDBAA5865C64E9@AM6PR04MB4215.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hLPWQIyaMJqEl8CWRqRUYlsUGRJnjMQPFMOoq7cD+a89CSeNB5roC51uz3Jh?=
 =?us-ascii?Q?kUVqYoiG0hss66bZU1P2groCWMvYCWQRBKhzuIdSxMPSEDSKh23JsLtTXiDS?=
 =?us-ascii?Q?1bzeaoAwMeQXYrvar/p0jFdaTOyye7wR61w/cNX6fa7QpPIKdhFD1F1u+TuN?=
 =?us-ascii?Q?tcxQBRYscH+9+i7oc4wbTmo3d75rGmetd//JNvLaHf5PE8PzIfAWecDn0gkc?=
 =?us-ascii?Q?B7keapym32GhVk65TJ1fz/Qd82Py6C+4SEOzHQuRrGEYME9Jys2nLInhFe2s?=
 =?us-ascii?Q?LhQP5b1vWKe+cBkKAJTZ5VaY7Yp3pTl3Fpi+WAtzqwN/myhp+RKLkLYPKxY3?=
 =?us-ascii?Q?l1UUuN6z2Y22pKPRSldAvpQKHIMDAlvq242xdSQEN4c+6FQjFG4WC2plbHVB?=
 =?us-ascii?Q?RaZ84p5PzO24k941MbgqNxYCvpsstlTZMh3uUZqUAdyF3qQSTK0sA9Fw7uMD?=
 =?us-ascii?Q?ss4a5XkzVQdwmxegSd7FCmzvRK1zCpFQp+YRupqwqUvzafJVBeqjbBVC8zRz?=
 =?us-ascii?Q?gLFuj5Riju2Wc3oCiwai0NtcEVQqv0MlqAFxGJB16hJIyfeWneH1YSjlIU8f?=
 =?us-ascii?Q?871vYoQFJ5WFwPn8d75fHxvGP55392lqJPV9RJo1jTMeWI3QC14aEGWdi/KR?=
 =?us-ascii?Q?Dm1COmi2uEF+wHm4oD+Nxh71KWPCVo/BpoI2s0/bpSVvkUOYAN29uCE10Z5a?=
 =?us-ascii?Q?XXHe1MIbnXPpBupaadKPvlfK3jJAzqv96z8MhxId0OpfIZPmrEcK91u3Khwd?=
 =?us-ascii?Q?nspVAEYtLBDntAYhR+Ir2DAWCrfwAMOAb5G7yirVQNp196278UT+axLyIEHN?=
 =?us-ascii?Q?bk9FR8NduV0brmrJ6K27i9v5roVXADguLwetxV29cu4A30Nzrjlm4SOg4a5l?=
 =?us-ascii?Q?misRpVk5aCzY7DnWVGPwPiJOaas9xKvjbTEIYjv+hf9ACMtnVKFlueOYUdV1?=
 =?us-ascii?Q?BZR0OQbDWOz4JBR04lGkyniQQ15g3U0sBZtj5xS5trN+ilTyT5KyDYT6XliI?=
 =?us-ascii?Q?Glb9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(396003)(346002)(39860400002)(376002)(136003)(69590400012)(478600001)(8936002)(6506007)(38350700002)(38100700002)(2906002)(86362001)(5660300002)(52116002)(956004)(83380400001)(186003)(6666004)(36756003)(26005)(2616005)(66946007)(66556008)(8676002)(1076003)(107886003)(66476007)(6916009)(6512007)(316002)(6486002)(16526019)(4326008)(8496004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i1NOpbQNuZo5+XBARGV1gyRgrU7L7afcmNge8dZxHjReU3vUhHbXfm61JZHO?=
 =?us-ascii?Q?xHnfjzls1mAYWkM/saIyQNvM0vxaDzCit9Ewl9d39x6YcgoqlQom6bGmXo7S?=
 =?us-ascii?Q?5tcETSnHo2ctfe85/5OIoHcfHyEm2rnfgwMg8aUbOmbzisUdmnF5pHhZwIOM?=
 =?us-ascii?Q?zyqzS8I9INFzzc74gg59xd2qdqpt229TAIEqroxrJ4uqzzsLii802wU2MDP9?=
 =?us-ascii?Q?8Tk/eX2qHjGtuZM40OpZ5n97YG8hMrhjK+7L+5fQRXkDCztM5otyc2Ui2dMm?=
 =?us-ascii?Q?IScp+36cR9BtUXP13IJ6HzTtUFWnTq23qBxBFdcBfyppiFI3E0gyXGQjbBMd?=
 =?us-ascii?Q?HYnRbHztmHpOdx9WtHimJ/qm968edk9ne6AC+wnvaRKODiXu2u5ogToq23OW?=
 =?us-ascii?Q?uvIEY63i9Om1B7YVSyUJwUJxC/4DsEcDh/V2aYTeT+gQzuptN2doqgMbQvnL?=
 =?us-ascii?Q?RwwRDL4OfgdNuuKavAbKpS0kuG8HpRBKHV02zcP74iPySjHmUQvkT+NqBFq2?=
 =?us-ascii?Q?P6/xJzOMHWLY5Zvhbu0pQgE5ysn8eSZvhdJ5hVtiAxlOZSngQ3blwVKUQMnz?=
 =?us-ascii?Q?p0xGPJl49DY1cRD/kwQvosa3m9ko00mCvOt1yF/0g6RvE8UhaudWl7x0miT8?=
 =?us-ascii?Q?ux7/g2eeSzGZr0MUDw9iXUU+mWIK21pa/Y1OCO9mSm++vsWZgrUP76xInUEc?=
 =?us-ascii?Q?ll6+4l9mhYLtWNubMNVD7rrrWcr0p3Pu3qTML3ooCZiol36vpXNX2Lo6Bu5d?=
 =?us-ascii?Q?NLSpdaNnMO0LSUD9c3/mdhGHHdj+vfjDh+NCQuV16w4Dft2cJCxtz0+iNguL?=
 =?us-ascii?Q?rV0X80laf78qXl1A5eyHaNghw0w+EZNoh8dcK7X+hCimvb+rfCZFD4tejrhw?=
 =?us-ascii?Q?GySCJeuU2XLLhfBZzKZRWICTMV6huLTao064zeMD1oCXXX+2nrqowf5jvkCn?=
 =?us-ascii?Q?SFLUG9UJoYL2SOCuwx35F7mWLOfb4GfqElZkE8MkdFiaz8GL5gHfX+XX/afv?=
 =?us-ascii?Q?W8VaGzknd2wP6xSk1Tyjy0lsFzUbWodZelsQLLcJbqoiU3YoMLA/viMMZLtF?=
 =?us-ascii?Q?anS7mwngGuYYQWTg+QAr5sV/Ow+EVu6j+3obSRaLD9OhrGtPcQrmzpG/DaNa?=
 =?us-ascii?Q?o5G8kd0sHUuXpshjdZl2ypEziuAYrSrBf6FHRyAEUwHmA+1VQ0lT7lIyDAv0?=
 =?us-ascii?Q?Aru+HTbYpy9Q0rBCvvHOmKXrMMb6ENBa2A30NfDUn4Ou22KK3AzyQLiy8TMa?=
 =?us-ascii?Q?VIfR56GJnGZ1/iymC48K75nepRWGVmb06Eoq5RhlkAuu+AEiYy174lO+Fu0a?=
 =?us-ascii?Q?iJeeN2ewMIg/+YGXYGgdovCw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c048fca-5a89-43de-74ac-08d8ff19d3bf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 07:49:26.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OU4HQVWkuZaVQXEII6I33e4OcBwa/ERILIJ53tbNfJTxP8tNo39kudRBjJCfZAF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4215
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The exclusive ops will not start if there's one already running. The
enqueue parameter allows operations to be queued.

Signed-off-by: An Long <lan@suse.com>
---
 .../misc-tests/048-enqueue-parameter/test.sh  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tests/misc-tests/048-enqueue-parameter/test.sh

diff --git a/tests/misc-tests/048-enqueue-parameter/test.sh b/tests/misc-te=
sts/048-enqueue-parameter/test.sh
new file mode 100755
index 00000000..4be7d466
--- /dev/null
+++ b/tests/misc-tests/048-enqueue-parameter/test.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+# Check if --enqueue can enqueueing of the operations correctly
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+check_global_prereq fallocate
+
+setup_loopdevs 3
+prepare_loopdevs
+dev1=3D${loopdevs[1]}
+dev2=3D${loopdevs[2]}
+dev3=3D${loopdevs[3]}
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev1"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev2"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev3"
+run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
+run_check $SUDO_HELPER "$TOP/btrfs" device add -f "$dev2" "$TEST_MNT"
+
+test_run_commands() {
+        run_check $SUDO_HELPER "$TOP/btrfs" balance start --enqueue --full=
-balance "$TEST_MNT" &
+        run_check $SUDO_HELPER "$TOP/btrfs" filesystem resize --enqueue -1=
00M "$TEST_MNT" &
+        run_check $SUDO_HELPER "$TOP/btrfs" device add --enqueue -f "$dev3=
" "$TEST_MNT" &
+        run_check $SUDO_HELPER "$TOP/btrfs" device delete --enqueue "$dev2=
" "$TEST_MNT" &
+}
+
+get_fs_uuid() {
+        run_check_stdout "$TOP/btrfs" inspect-internal dump-super "$1" | \
+                grep '^fsid' | awk '{print $2}'
+}
+
+fsid=3D$(get_fs_uuid "$dev1")
+if ! [ -f "/sys/fs/btrfs/$fsid/exclusive_operation" ]; then
+        run_check_umount_test_dev "$TEST_MNT"
+        cleanup_loopdevs
+        _not_run "kernel does not support exclusive_operation"
+        exit
+fi
+
+# Generate 1G data, for enough balance time for exclusive_operation
+for i in $(seq 1 5); do
+        run_check $SUDO_HELPER fallocate -l 200M "$TEST_MNT/file$i"
+done
+
+# Do btrfs balance in background, then try commands with enqueue parameter
+run_check $SUDO_HELPER "$TOP/btrfs" balance start --full-balance "$TEST_MN=
T" &
+test_run_commands
+wait
+
+run_check_umount_test_dev "$TEST_MNT"
+cleanup_loopdevs
--=20
2.26.2

