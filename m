Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025F53628F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbhDPTyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 15:54:31 -0400
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:11532 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244385AbhDPTya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 15:54:30 -0400
X-Greylist: delayed 1131 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2021 15:54:30 EDT
Received: from pps.filterd (m0118796.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GJWIQ5021467
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 15:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps-02182019;
 bh=yTCex41YL4vsH4SKse1ldc37RsWikO021qYP8jDp4dY=;
 b=r2AeH7JUUi18bgVF8c++j+BiuIdTL8fXHWWVAdDFrgkwJiII07JF9FvbyhK3dwY3uUzb
 1sn1RetdzfU2A2J0hcUomwOClfTuYr+7hETJrzTLMZT77X5milG3NooxiN0H1+MwSSfJ
 OcPWOqymk7zcfoFb/8+ap8jwLfR60kK8xojJtBZcI2dvUn7U9bNYcit99AyKIh+gS6RA
 2R3WDU/1PcTDQN7/PHr/qjEd4kjc+0SfhXOVpGKop5nAlqb3NGJNXZjJY/YuxXEIQkEI
 6lnLb4xwk7a5WtqsWv4t/sKNb65U07BD3ZdoTgVz7UYLWZ5At0Wo0vrHPE7ejNNllx1w lg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0b-002ab301.pphosted.com with ESMTP id 37y6hfgjsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 15:35:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAU9YNV6iPOFyrZjero8fR2w7WF96V1OSJO15F/kE8hLhl2QIGYua4FM0VTFLLQW7fbhLLGjp7mpBDXZn+rHjlF4QyGJodTMor2vceDJuKVI9qg9ceQyeaTvTkzcCAO1f1sr2/tOsrR18kz8DZa4DSyccEDnQ3UJPf20LOC3Ebl+rjRhknwJltHf5F4iTChrfKzcOHTeKbd/fBlUhPzv+2Gsqgfy7Sg1LJUBpwH/oycS3MU7CxTzaPgvKucfeOZ0swSXOzuM9Qxhp57w9RfRV1tyu/7aQdpF/kdyuGUaQ9aa8KYld59ew/EdbW+cvGRXIlk8guMtCJ711V7NFMSTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTCex41YL4vsH4SKse1ldc37RsWikO021qYP8jDp4dY=;
 b=fYtX2iwq1bbreMFmcslxe9QqZpU+wdaT6u7FXE5ZyC9WRgVRpAnU7R3wyz16Kc2d/5Bj/fmcFyhxwOhyqZM49tRWd2NfrXMZxqG7Sz6ReXIPSclN7/qoAq2WnsEz8fiKHpvWwcy6+8myc3xFci3QWYiLnP3O172Ig1tnthUQVyoTht0ptbp+wy8b5IMXhQ7lOTJrsilOjgh1gNm7KeoUKXScqKzDnfifc2UavEqPc8mEcYToTbOXM8gOvavhNh75Iu803rK5wzt/t+4j6Avgq4FKB/Zh1mIexOZmAoyMtMScGmQLDALahgM63t6pbT79yGZMdNuSnhjhaSo+YrOlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTCex41YL4vsH4SKse1ldc37RsWikO021qYP8jDp4dY=;
 b=jvvcp1BV5sXOvSwl/+Q2G16IerAuzriBbTTDCuL59c0tGOcYClLN8aurc9gaWb6CtFSRPZG2FpOcWrLBEKJaEDuMeLBLOmvJsYKa8t9XeUojQ1fDIztgroTF7LiFAsKSLqhl5dbIpZlznJvsa8ASELNVUNaM8FK3xNnWakT9SxU=
Received: from DM6PR01MB4265.prod.exchangelabs.com (2603:10b6:5:22::33) by
 DM6PR01MB5403.prod.exchangelabs.com (2603:10b6:5:154::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.20; Fri, 16 Apr 2021 19:35:09 +0000
Received: from DM6PR01MB4265.prod.exchangelabs.com
 ([fe80::8c02:ac28:592a:406b]) by DM6PR01MB4265.prod.exchangelabs.com
 ([fe80::8c02:ac28:592a:406b%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 19:35:09 +0000
From:   "Gervais, Francois" <FGervais@distech-controls.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: read time tree block corruption detected
Thread-Topic: read time tree block corruption detected
Thread-Index: AQHXMvQIVkE2UJzwZEu4ya+WYER7yw==
Date:   Fri, 16 Apr 2021 19:35:09 +0000
Message-ID: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=distech-controls.com;
x-originating-ip: [76.67.142.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf28fa36-b19a-48a9-0bc6-08d9010ebee8
x-ms-traffictypediagnostic: DM6PR01MB5403:
x-microsoft-antispam-prvs: <DM6PR01MB5403F9F30817BB0D889F2E66F34C9@DM6PR01MB5403.prod.exchangelabs.com>
x-pp-identifier: acuityo365
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //x5nE3EuVz6rusks7+VzCxLO4Ax8HBE8wOKW52dIiquYXRVEuyiUmpzP2HLiu8hodLYKjW3pYAW7qaO2BMJsFfGERVccw5JfxV+DbEeFBk3a8vfTeHHz0TtolrJ1bFR/wB03pn+8Ac0GOZFA7CvWJBfqucxxF2LSssimAJykM0T/6jJ7x5FmTY3+ysrs/QZRaRfj1V1lZsidvKI4BHJciw3nus+xgYuDQNYFE5XLhYG/TaJiy3R2RXeEt04wP4u4vmBUWQhBIQhvkVV6b+vhh0125Oxj/iXeWwlM/YzUAsZE+6EjMS8udoT8wXv24VEvbbDKG7hehTefYwG4j1Bjxa061ahSqVkyBqfHJM2SRtwbfu/4iJtQnYhRV1GH3H391FQxvEqkRzPIHaQUM4T2K/WqzVI1OJU2h/fBkSb2lzS+Je9wsC9GTHepKvTtpQqrIbJ/qB4M2qf5Nmn37JB6FY1FwaIU8JJ/IjobA3PlX79nHMueM8h4N43RFOkpv38OTxXOhMOK9MQHm7tobN1u6H7/qlrwH4clLmsbDhi5JV8FRJn3dwHDhCBs+speE8a+bLQx8AfQc7wgNpMPO8qWLiUCfxE57xWt+PRdYlMZ9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4265.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(55016002)(5660300002)(2906002)(76116006)(6506007)(6916009)(66446008)(86362001)(83380400001)(9686003)(122000001)(91956017)(316002)(26005)(66946007)(7696005)(33656002)(66556008)(38100700002)(64756008)(478600001)(71200400001)(52536014)(186003)(66476007)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Vhx0cLmU94LTk+mEYhZ/ayzlAZrofKjor2A6VVXWjrTJ1NRw3aOjbbfmd8?=
 =?iso-8859-1?Q?v2PQ9bKVBarvTfOZUdO7N5FHOX54bob4FOaWpbLvwjVO/fZGZKIySNDqk8?=
 =?iso-8859-1?Q?FrQPxcOa1v3WUPa28pjlOUA8xmWKNMcoNrSPaBeXy/QlzZVOwgCqwaA1v1?=
 =?iso-8859-1?Q?Ru/UXNgstqzfnMYOBetFhuTi26CkxHQ4AL34mZ7c7g/7Td7CWAYCRpz1yU?=
 =?iso-8859-1?Q?JkGJrmCsH63DSoZ7N+HH2HP1RwbL26z2h9tu65++5Wsv59AQ9X1N6HXO/g?=
 =?iso-8859-1?Q?L7WoRG1lW/1QiEboHtBL6wde9CyR1Jmb6WeHUYSIOl3liVVHFI6lhCola6?=
 =?iso-8859-1?Q?HLNct1/U0vdkv5c2IZ8Eta8k9Q9kG2DHnTYVnRIYgZR5wlYFZFwx2rFevU?=
 =?iso-8859-1?Q?TLHrriZPf5HKDgfHn7DIr4W76qkGGM7xEp6tkTJhI8Eg19H9Hz1T258qcf?=
 =?iso-8859-1?Q?w7wX4UARuLJmoat7jWplvl0+H1nYo3nnKetPAloOp8uGykroGs3Js9TIKo?=
 =?iso-8859-1?Q?j8DckttDS8XnHLo3bivR6zfaZxmRgB4cIZ1U6/00qRR/FKuZG1DgVkJRmo?=
 =?iso-8859-1?Q?/8ZVDAHXAU05Ev2yXbKfg2KfdozM7Vz1ABYujTOmmknP8ZR+1RaWzdqdHr?=
 =?iso-8859-1?Q?QFyxQ/53Lc/lAdmQ/ycnNWoFNC5dN5o1ZWzEStgS0Awu6QyzLz8gkWYDWY?=
 =?iso-8859-1?Q?Nb/+DgUcdv+BcOfJAdcs3WdHtQjkhTwJ31+Vj6rF88zUKQOuNmlY12+cGo?=
 =?iso-8859-1?Q?A/hjW6U8CzqH5lqQaOn/5fVanxighDzQ7tbiGAMcawXxidONhI5TEXKrKl?=
 =?iso-8859-1?Q?jXoCi+d+jJiH7nQcJrYeGyO7jn4ONDns4+S3MDxIo2NtlJZXcbvjw877oU?=
 =?iso-8859-1?Q?muEtLT3s/FnSRGtAzwNLgCpk3xNm2HENtlJMjQLP5x2vyJTRH3eTWIeMC2?=
 =?iso-8859-1?Q?MJAwbhYEPrnEfKrZ2OcjlUESTvoQr1yHLtUZwBxHmIMr2RHuNJO9HjSo0W?=
 =?iso-8859-1?Q?N3Jlulj7izZ1+KIJmIjtVE9EovdIWNz2eKYzo9PaTX+HTqDmQ9+rOSjKEG?=
 =?iso-8859-1?Q?DEtRRVmh3A7DxB556e3NJJ9mrAbAtr6qQOXRA/n82aWr+dcLbxbiB3UwWW?=
 =?iso-8859-1?Q?vkBJY8sm6wU0Vu1/KhBSN2/MLNo6cz/96k1BDaqcMBl6tnME8EqAJw3Sk8?=
 =?iso-8859-1?Q?UME3MArw8FZQa923oELbcZ6dvAWanPQM5JUj/JIPQDXP3PP2i2PNznZG/z?=
 =?iso-8859-1?Q?T+L4BFWyw+o3BnAmN5CmI5jM1qiysHDAjtMlMfUEDnfTIL6RD4xPX1ACI3?=
 =?iso-8859-1?Q?jH/ELXW/rPBV14i+aM0DbueFMNs+k6/ML0ddT7jOztcNKGM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4265.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf28fa36-b19a-48a9-0bc6-08d9010ebee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 19:35:09.2794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cchuz2/XqUNXTK+CcELBB4ukdE6wu7UJwhjTdVyFbXatw1+rROP8m3ZGW6FAz113WHlq2l2rnSSOf6G8eTCjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5403
X-Proofpoint-ORIG-GUID: 3UlSXTWJOBbyWsW57q_HhkHOmfOxn5Rp
X-Proofpoint-GUID: 3UlSXTWJOBbyWsW57q_HhkHOmfOxn5Rp
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=829 bulkscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160137
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are using btrfs on one of our embedded devices and we got filesystem cor=
ruption on one of them.=0A=
=0A=
This product=A0undergo a lot of tests on our side and apparently it's the f=
irst it happened so it seems to be a pretty rare occurrence. However we sti=
ll want to get to the bottom of this to ensure it doesn't happen in the fut=
ure.=0A=
=0A=
Some background:=0A=
- The corruption happened on kernel v5.4.72.=0A=
- On the debug device I'm on master (v5.12.0-rc7) hoping it might help to h=
ave all the latest patches.=0A=
=0A=
Here what kernel v5.12.0-rc7 tells me when trying to mount the partition:=
=0A=
=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS info (device loop0p3): disk space c=
aching is enabled=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS info (device loop0p3): has skinny e=
xtents=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS info (device loop0p3): start tree-l=
og replay=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS critical (device loop0p3): corrupt =
leaf: root=3D18446744073709551610 block=3D790151168 slot=3D5 ino=3D5007, in=
ode ref overflow, ptr 15853 end 15861 namelen 294=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS error (device loop0p3): block=3D790=
151168 read time tree block corruption detected=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS critical (device loop0p3): corrupt =
leaf: root=3D18446744073709551610 block=3D790151168 slot=3D5 ino=3D5007, in=
ode ref overflow, ptr 15853 end 15861 namelen 294=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS error (device loop0p3): block=3D790=
151168 read time tree block corruption detected=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS: error (device loop0p3) in btrfs_re=
cover_log_trees:6246: errno=3D-5 IO failure (Couldn't read tree log root.)=
=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS: error (device loop0p3) in btrfs_re=
play_log:2341: errno=3D-5 IO failure (Failed to recover log tree)=0A=
Apr 16 19:31:45 buildroot e512c123daaa[468]: mount: /root/mnt: can't read s=
uperblock on /dev/loop0p3.=0A=
Apr 16 19:31:45 buildroot kernel: BTRFS error (device loop0p3): open_ctree =
failed: -5=0A=
=0A=
Any suggestions?=
