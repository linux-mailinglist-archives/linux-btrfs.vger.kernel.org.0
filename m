Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B672D7A7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbgLKQDZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 11:03:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24653 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395408AbgLKQDN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 11:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607702593; x=1639238593;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=t5J4MVky9ZvB+z6WraoO+jXkf2EX1NEKOXDwu3p1uzI=;
  b=HtX4X2/WlOcOf4ts4vGJeX8qyX4vcyImXhAC3ErToOeyeyLENLjbNVqU
   PuikJFjhqJdVYNmZfSMUiPdDZ3nOG3agOVUNxYJmIek3i8ZvIVPaEKIF1
   bJjdgbIT3MljPoMZXai8qMZ4G8nZ38atADxItuv2LaIHh7z1vBmpLoZ4Q
   8QC6fXqWrm2Yf4rfvesTwEqtwj/XBdtACydKMrvur5VD/JTsWZxNpceLa
   TGXZjXiYfErYi0PjISy6pVgyJkjw13emxoD84SM2k5L1pUvWMcz/L0c4r
   Uvr5rXDWzNTdvc9J5TfVEUJogf1//fZvBHQKduYvEze0eHjvRtwHcPeuR
   g==;
IronPort-SDR: +byg1Q0BhO6KexPCszlNp3HJdijrohN4aB2M5EXndP0hpm9xaq9TZ4BYXNBKb5bZvRIx6U4p5z
 QL1jvLN1kchcN/sBwnZhErqQIbt2ttelKJ0yiQOnHJgkfZsnPBdIMDqpnx2PYS/R1nrw44pio6
 LAcnFMo1wo97Cnpefh4D6Ona0aeQI34zv3OaAjbZMxgtToEMwQMdU3XJS7mILQ0DukaTVcpVqT
 kuaC+J0bm1hFtfhv3c/zJm1ZonYCI/j2s19jN4Ri1RKfwmSnVIWbwzHWsturDIG0bOnzQCqrEv
 Ku0=
X-IronPort-AV: E=Sophos;i="5.78,411,1599494400"; 
   d="scan'208";a="159410182"
Received: from mail-dm6nam08lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 00:02:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZVkK49U3tZ5cUBYlLbU7QP66zj7giburSAiFXUJj3yi+J46r/0YFdRY79Sk51ddfIaiMDNOUZbOCQyG5svSNCxugM/quiHseaNqkszjuvRRqKlklqL+S0QyD8/i14kA9vxAr8mLRMPxqltkR4ko0Xr4zdmtvPxoV28DrweYTnwMQYpclBnpwD4CI3WIz5VZE8LRa556l756mmjKZ3elngW64ZsSQXWnH2vVWUGfQUT7l4O3fcc8shi7xyoCDyuyIW/9RsnkEXcGF+5M14XkvM4KA2aTozgWT9Vefgk1r6t9qJdfwt4HVX+Y3hDANAH6QVeQBmczYXFYI/xQDr5tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5J4MVky9ZvB+z6WraoO+jXkf2EX1NEKOXDwu3p1uzI=;
 b=c+fDIVNccb2MrJQRjPIyXd8U2uth2OpCSlVh7XWtdItPU3KdeLZMvunC+FyKT0TO8L3xdMc2nSIksp9x+xLct5cemkMqOQdq8bxGS5UVVvCI8a+hhCm0SCYo91j/zHQ75vMp/Ho4wgG674T65G+TYXE77nR1Gc7tJwoiO9f1rpcTLW5NNUjM2xXznQ+3wftHi3HXytLmXczOoRk/sb6KKeh0NVBfBn+b/D4fOU1AM22D5W32ZHd2Wlt00Q4e1r1+P8bNpyTE4SwdQMebBtB5XBY+c9exZ/f8SxEHuQde4rna4oIeQqf9ALUdRz/jA7bbZJILZLPyK7eFKVOUF95FNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5J4MVky9ZvB+z6WraoO+jXkf2EX1NEKOXDwu3p1uzI=;
 b=fAK9EKjwtHFc7qOU7B09vDrI1fIeATgoJU+8WZcheySbixZ32mZn5NUYUvGJhuzTgc5bI6UjWzHDK34NXqkPnhra7ncuWrLNkLrqvIJBXPr3m6HGTMWbQ6masrQckH+8SwSlq++yEfPJFgtYfq5KqGaXEL7OWfHtftC/TLaT150=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3967.namprd04.prod.outlook.com
 (2603:10b6:805:49::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 16:02:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Fri, 11 Dec 2020
 16:02:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has
 mq-deadline
Thread-Topic: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Thread-Index: AQHWyzejHW6Ri+MjBUuw45QEtiWblg==
Date:   Fri, 11 Dec 2020 16:02:04 +0000
Message-ID: <SN4PR0401MB3598ECDD1EE787041F3C328C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201205184929.22412-1-realwakka@gmail.com>
 <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201210202020.GH6430@twin.jikos.cz>
 <SN4PR0401MB359892AE5C0771A8209A4A559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201211155348.GK6430@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e2cb8d4-e853-470e-e2e0-08d89dee1ac4
x-ms-traffictypediagnostic: SN6PR04MB3967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB3967C53383717766B8CB1BAC9BCA0@SN6PR04MB3967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VERLdeFRB7Vjz7loXjrJP1kuRBPNiskO6xwRMTp2WhRXoG7drKE0HtcLCtVeSrAgugeJ2I951chpatVpF1htTGpJjdvTYXDzUphc9/4g6dAo98tZ1lGMXUJeZLxY7ZFVYPFo5DUHaBajqSjMAN6STypeo9TRxFURfIyK7MbvPtf/BH62YMmOhkdDg0/AMgxQMS+G5pHBubcLsIKyJ1dIlFUUqVhhlVTBJw/0ArXye5oAOnH5/ZZVzf2TfrW5Zd9Q7BBitb8sYH14wgYbGWyPWSxdufTgFeHB1xoZLY9vgWdCxh4v/CjYgTYWNDaOtKD5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(71200400001)(6916009)(508600001)(66446008)(66476007)(64756008)(66946007)(76116006)(66556008)(4326008)(83380400001)(5660300002)(26005)(86362001)(6506007)(33656002)(52536014)(2906002)(8936002)(54906003)(7696005)(55016002)(8676002)(9686003)(91956017)(186003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G1AFTyXpV+6LWu2xLSgV+VDSjMDVmii1khW/oPoMZGnpdf56pXmCTFvGWwqn?=
 =?us-ascii?Q?m7zhgawitrNGU3NUFef7CcFrU8NcYyVi2UDbDVbOJEAhaLzzXF8GKkQzxQZ9?=
 =?us-ascii?Q?IOvxqdF38jRQ1l8Kc5VJUvB/H+uojo7ck2h+8tio822YTMnZOIaJBbn2I95z?=
 =?us-ascii?Q?K/hfMxlIT1DPgv64yuHay9t3Oj/xiEJyJdiPTQXXo8TDlokvWjPHSlJJ6nE/?=
 =?us-ascii?Q?YiCcqRUqkJDlqU6Lb2EGuy4kccpnuqohugQp8LrrZVwtABs3Zgxxg4RK6Qo9?=
 =?us-ascii?Q?Zjcln0nSpWDapucB386eokhibOExR3wAZz9wd1FzFXP4oAG+T29dzmNjIoRx?=
 =?us-ascii?Q?W5n9/k/5sS4pwIeLJv/Mix4bSBfVTKrK2SswQppdjMIwBMIBYHguzcnUnBjD?=
 =?us-ascii?Q?jSIqMySD0b9PLjo2HKQ+mTdueOFptu4G3nQgJr9s+1t3e/gg0WLI7t29ZP90?=
 =?us-ascii?Q?fsNSreadf4Cwfcpy7dyUoE28rhzaqJcN2mavgTICaqeNIdMxFbRZ5TNQ5lSy?=
 =?us-ascii?Q?oDyBxHyYN4+ORM/fmn7RYIg7PIQ5EFKgF7eH6d7dc4Y6rbgmumE627jJ5Ybj?=
 =?us-ascii?Q?tstFkHXwvUtczorLG78+toU/GG8/KPdL4Rk497xRS/CdFTVmIIEAwzNq7SaI?=
 =?us-ascii?Q?huzw8yNFJCDXFtGA9h8n7KgtxnlY8bJp8QKSDUzMejH3M1Pz67jpdvExvlRI?=
 =?us-ascii?Q?pRLj1RWmpIFqWmJ3f7SqN3SKY53OJ2GRIBdPswFxgnl/6DZ3s6lwu8ERlADv?=
 =?us-ascii?Q?A+zUmbb+CDMfniOGPKT5hGPKgwyQEd8hOrvV46JPBn1vwwOJFd2mWIwBUOj5?=
 =?us-ascii?Q?dHLOvkLDkgoj8axpgLxF56V8OMVIWNlyzeB2EkMo8CNeMWPsyidc++oFB4Hs?=
 =?us-ascii?Q?jPG3/h3grH8hUzi5ixz5GVtkm5CUlePHdz+42UvG2lYPqRwznXTDDMtyRku8?=
 =?us-ascii?Q?HOtt9DB2DU38rDDLvwl796tbbhhN4TBr3/22e8ugCbOL1n3TSYSgRXYTrF7H?=
 =?us-ascii?Q?rMyW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2cb8d4-e853-470e-e2e0-08d89dee1ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 16:02:04.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgmgwseKveIzI+x3+4dWTSBGr8XVc0UoKjgTAygEHrMPfg1AUee7NVa3bE+4EvA+HUlBANVfpbBij17vndrVT55jEwvKME3v40I4yZSvDKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3967
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[+Cc Damien ]=0A=
On 11/12/2020 16:55, David Sterba wrote:=0A=
> On Fri, Dec 11, 2020 at 06:50:23AM +0000, Johannes Thumshirn wrote:=0A=
>> On 10/12/2020 21:22, David Sterba wrote:=0A=
>>> On Mon, Dec 07, 2020 at 07:23:03AM +0000, Johannes Thumshirn wrote:=0A=
>>>> On 05/12/2020 19:51, Sidong Yang wrote:=0A=
>>>>> Warn if scurb stared on a device that has mq-deadline as io-scheduler=
=0A=
>>>>> and point documentation. mq-deadline doesn't work with ionice value a=
nd=0A=
>>>>> it results performance loss. This warning helps users figure out the=
=0A=
>>>>> situation. This patch implements the function that gets io-scheduler=
=0A=
>>>>> from sysfs and check when scrub stars with the function.=0A=
>>>>=0A=
>>>> From a quick grep it seems to me that only bfq is supporting ioprio se=
ttings.=0A=
>>>=0A=
>>> Yeah it's only BFQ.=0A=
>>>=0A=
>>>> Also there's some features like write ordering guarantees that current=
ly =0A=
>>>> only mq-deadline provides.=0A=
>>>>=0A=
>>>> This warning will trigger a lot once the zoned patchset for btrfs is m=
erged,=0A=
>>>> as for example SMR drives need this ordering guarantees and therefore =
select=0A=
>>>> mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).=0A=
>>>=0A=
>>> This won't affect the default case and for zoned fs we can't simply use=
=0A=
>>> BFQ and thus the ionice interface. Which should be IMHO acceptable.=0A=
>>=0A=
>> But then the patch must check if bfq is set and otherwise warn. My only =
fear=0A=
>> is though, people will blindly select bfq then and get all kinds of =0A=
>> penalties/problems.=0A=
> =0A=
> Hm right, and we know that once such recommendations stick, it's very=0A=
> hard to get rid of them even if there's a proper solution implemented.=0A=
> =0A=
>> And it's not only mq-deadline and bfq here, there are also=0A=
>> kyber and none. On a decent nvme I'd like to have none instead of bfq, o=
therwise=0A=
>> performance goes down the drain. If my workload is sensitive to buffer b=
loat, I'd=0A=
>> use kyber not bfq.=0A=
> =0A=
> I'm not sure about high performance devices if the scrub io load on the=
=0A=
> normal priority is the same problem as with spinning devices. Assuming=0A=
> it is, we need some low priority/idle class for all schedulers at least.=
=0A=
> =0A=
>> So IMHO this patch just makes things worse. But who am I to judge.=0A=
> =0A=
> In this situation we need broader perspective, thanks for the input,=0A=
> we'll hopefully come to some conclusion. We don't want to make things=0A=
> worse, now we're left with workarounds or warnings until some brave soul=
=0A=
> implements the missing io scheduler functionality.=0A=
> =0A=
=0A=
I think that's all we can do now.=0A=
=0A=
Damien (CCed) did some work on mq-deadline, maybe he has an idea if this is=
=0A=
possible/doable.=0A=
