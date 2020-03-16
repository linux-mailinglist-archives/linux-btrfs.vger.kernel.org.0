Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C41867CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgCPJ0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 05:26:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44189 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgCPJ0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 05:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584350797; x=1615886797;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BEGyWpkc+wVt1f0TtWQvfh6YAzkUSe26FEXv4GwvvSjbN0C9DaNmu/0i
   okOS/Foo4XO+JC4Ut4+UYFiWJ/5cNqHAAL4We38lBrLXEEkIG7lKQ+r2R
   JC7TGXV2dAE8uzE4BZX0k+NHLEb5kb7gStCu3xZZwINrRimEAsvM1nR9D
   4XbqoYs5uZS83ipBMi3IsP5wsLwNk+zZSbs02mKkRATovaNZBSLdVbUxr
   Nt4jPwi/qYvhSAiXOMch7iWXNPUTQazUfCL/EAK4fOyQQlHqC31ch4CW7
   1YKV6mRn1MLEAuNkzgl7YeaVVxiJhlRR9w4nRzh9SemxTfWSJa3p1Rdet
   Q==;
IronPort-SDR: MvuPUbr48HF1LUUL672js9q0UpYFFwyqo3uvC0+BHmk6yBa/uY6EfRelt0ge1KQpElsOibxaFL
 /vCQ8ntmT64IsRsnFIesi29qHgFn5Xcc/nJnpFHBuxIP0gOu7F4BdlfShSM01qK/7eQJUjGah+
 TSK8f//MIO+oxSu5Mg19yrxImVt4NDS1tWwJqkCUMe1YlGUYt9+TC+uYDvNb1xv+/pwVwX412S
 /ZiK6cSgZ58YKMjoKWPmaMsAAs7pQd2h+/KbPRqEMEG/BrZz93JY3UqEmeUA0eiHow9bFty53f
 GlU=
X-IronPort-AV: E=Sophos;i="5.70,559,1574092800"; 
   d="scan'208";a="136959586"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2020 17:26:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVjNyHXFfekTD4DcFxhM2NdF1KeaSc0o2HGFnmEXIupnt3LYcfFdFeckThFklaT9V2uRhDvd81YOd/3kkZW+0CgIW1ByBc0EfRBjjqsDbjUiI+W1IPGq7s/T4EWhWJRUlfSOd52PH2mRICgy8tnLW8j3A9Vaf/gH35kIolbNT36CtqXNLlvS4cRlATmSf2tP+GDUZMynSDA7msJFleRSbhA2chBq1hiCK8KcQst5Xmf1pd/7bMmuAPmCoIRX4SCCbLuvOTDr3IES99f0iSu5qEFSaoE/6WBDKOlRlpgcw+EVgRpetToSbKeHn87AqL51F1VJB4+5G/6u/ZOeQNzaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hI6UStE55IkGUCiQpocp3M2v1fEzPLGSHaDYPh5CXEqS6PjAD/bQKYamEOIaKDadCGmllzeHxsigPCLbRLAPEYfVYaB56Dg4gOOIu6VVsoSH4vk1Yj0xJP4nekYBva4nbnjsnE41mVqkyhVYeE9pDfmcA+Vur7XQHypjMICaqQi8wEwxOjQFjefcoYttDUIe5UVW+LwuzjRofvYJYSc6xB7FvSPFE5uIcqPPtReMWnDGmsWZsfSn7UgAixPq+Bc66dZ5FttCmLez7jKNSXZN90OU74F8cMGXoW1vsk5bMRDwGYdIhAKPu1UaUOk+H1Is6sGoLKiw3w/tRJNUbTGZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ycM9LmEIknYMnY6QAV+H22fITrazrUQSFSuCvCycXjot/12+Wye46cmO+K+o0Db8T3QhPYBnH83+4TKhBu82TUiISZttSfj/33qE5zWjyPAPm1M5bev2F26achzUugI50ayUbAGMO5Qocu7BuPfL2X4Q99f/t3+BzlYRiP4AaJE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 16 Mar
 2020 09:26:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2793.018; Mon, 16 Mar 2020
 09:26:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: Fix xxhash on big endian machines
Thread-Topic: [PATCH] btrfs-progs: Fix xxhash on big endian machines
Thread-Index: AQHV+3IFC9PlMOSj9UaUY4eJndn1AQ==
Date:   Mon, 16 Mar 2020 09:26:33 +0000
Message-ID: <SN4PR0401MB35986690DE71F4759146D3E69BF90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200316090512.21519-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59e81672-5192-4f15-5c9e-08d7c98c1e33
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-microsoft-antispam-prvs: <SN4PR0401MB36791CA7AFAB145DA44D1D519BF90@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(6506007)(76116006)(7696005)(8936002)(19618925003)(91956017)(66476007)(64756008)(66946007)(66556008)(66446008)(186003)(26005)(558084003)(71200400001)(478600001)(9686003)(52536014)(33656002)(55016002)(316002)(110136005)(5660300002)(8676002)(81156014)(4270600006)(86362001)(2906002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3679;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: looY7iHo7VvUbe5hFee6Zpxic9SluUI1Vadih5LQaK8FLfjUuDekTkpsbgwhXlqYk3aix6cBW6BuC9EhkwT/GkFbfM5aAMPWtmdrf9upvVf98v8QYnwSANKBunHd3fntSEBfbo1PxEtAf3/qpUaZT1PTlXOYn3fhaNfedlIWdxFbRJEQm9u7ynxRbqAHQweZh4NIE9zzBC29J/u4WrYUrqjRifjYsNNWluYTULgwjTF210srqNBcSoaODxD9d3YnqlA0ggf/501ATUUYu1p/Bb5CGZmgDzzcr07v/QNLDugd8zIpDZdruG06cVdRUmeqEHtv6YxTlY94xOKqt2gK2+7mQL78u8tbcgNPZXE+7JQ2dY9qZWtH+i+CRSrfQkRcCxwvsY+lOGXYWs493LHFvxmuK1Za8HELQ3Pkfu6z9NfGV910PDYGNbpkKWZtma5y
x-ms-exchange-antispam-messagedata: lQ+Vd2ya3oH+hRy63youFeD6rfx90NegY14JtF9nxFZim2SH2WBSun9GCaHNEtEFolkkdeH5+SFud+enrtt/+u+tak+R1+SUIdEJ+60jVDkwedokJ/K5Zk6slpPLpW8D9HgJmsW7vz13Lichl9sFzw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e81672-5192-4f15-5c9e-08d7c98c1e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 09:26:33.4152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcFKBp/qWlAfzvitLblSRAAB0MT4j6EKdBnSX8IWkt/30zO0ccPxXysVWR0jD2OtpMCD6yiDdLpri1o79IIYHAeqS/WAFQjWgFrcwYXA3Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
