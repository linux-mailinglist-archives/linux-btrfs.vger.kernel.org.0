Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906B429EF15
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 16:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgJ2PDb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 11:03:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2373 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgJ2PDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 11:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603983805; x=1635519805;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PE2Nleqq3xeKAXRux/aZwRfAZ/F+xX25Bla3yxsyFSs=;
  b=L3GnJ5NGDgCcS7WLDXpWw5wEyrDTWUzLGiKaehTpEzD9adrCawNBHQSI
   Qf2yYo1Bi18psGZOBOLw9TSCKvX/sdv8hZQFvTIIgiu7udRioU2+YMdBy
   uk5FzJ7ysDB1U3ZBK56D18I9OCnsnBF7qnGcd1iBHSnYHExyulifmCShq
   0tFbppW0PeumGTr247t2xj4ciJ20OM9DJhMhUKv5+SYINs0vSIa3dMTs5
   d6cMq7nMHqVSB0vEjhJ8wAcsK/wJmGb1pqtifQjvMKETXsgRlB8L8XzC3
   sNwyRkvyCHzREMCaVVxQOftwrUYlZSPX08aamfO3P+CnLgvCM/qOYMDXP
   A==;
IronPort-SDR: rm/dkij+FoVYVqA/UgcFYFW38GbP6XM75p0iX/Q+Qp/RMT3MaUCAEZsMgmLP/v02+wDdJKil4X
 XcwT191v38sc7iS6Co6r+3IpyNZftRk9qaP5AHsyGfB8J3SKr3Gvlud3qrk2Sre5P0RCLg/bAB
 nb/LmFIyYJnkMfl3ysr2H+5I7a83G51gMkFQgR5u90yqqHxOK9plxdQ+lr3U/tCKYR0hAvvMwj
 MnNRxtJcSGJCNLeorxeZ3V9cMyUxTLoPvUcQPTE23leulDEoDA7CwJCr4guKQ67529FyMOg8iA
 /As=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; 
   d="scan'208";a="261167918"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 23:01:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Syh76T/u8aulKfTz/dLjcTwWNxfuO5a+5XJ5ZlR+JiBHDWa/dm0ivDK1f4rYi7yTSiD0qOOyx5LiqSS7n3oHO8je5n05KQOt7ks954qeoT8IlrCpQbX2KslhJY3JzrAME76yM46gwm3LAikaQrYoUiFs5kp1iwxhk7X6N2NSshtGFwXhyKQ4Y3GRIyjkD9c/Vvk+aJJobbMd8/xJSwe9zs0CPUhl9Gi8JIxYLT6XLO5MV4VKYN4dsHZXeEaeQ+HbrRFFFa6Zoiusc2glS1KZMzwvA9HWaVpxp2QuksFo0x3ZMpcmOxj5JIstn4byHSKQ+yIDSusB43P3OomXpuunew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icXIFj4zfItEgfUQ/bEXuK8MWsOSrJibjqvZ2ZbEM58=;
 b=Gu7m+zNcTQ9PanTa/1RDZ+dl8dwB9Wf8LO2a+h2cJi3+cjT+6z5FTS2J+lemrsI7xdXBxe+B36bAjply7lCFCtj//pkzJ5b79Jxy1+eK92cBPhWbycTe1mDLPPs2bOpNJhSS4dI1KizVl9RQQd89K4HMEM1xE7X4uYa3nGzN7ZqgVUAdNZfFwfGwIDNNP/OSBSIKVGTgkHFjcSw1a7XJOjBxi4DICpFWK7zi2eiDNOM17bq3zoI5YqSIMT+kw9ZsHA/q7gTWkhwHMju+znOo1TZyOkkfYPwFfPPR02Exp8cPiAcxSwbwUpQ8T3J7Pw8K3lRlzDegAi3MYngS+sHd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icXIFj4zfItEgfUQ/bEXuK8MWsOSrJibjqvZ2ZbEM58=;
 b=sJ8iAfeTUF1cewt/Ht6vTJXmVrD5Cmd7LVdA1JfM1m80NmMXw6W6Nzgrp1s+h7IE6ZJqt41JIprTmOAFBjLNeXdS+STiS1V/hayHWJKEnlIVycB8HbQcreysM0W349Yrq3Rd8QlO9LNnD1w5sBBjh2Qid79q8JIxJYrJvGTN5sg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4605.namprd04.prod.outlook.com
 (2603:10b6:805:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 15:01:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 15:01:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/10] btrfs: scrub: remove local copy of csum_size from
 context
Thread-Topic: [PATCH 10/10] btrfs: scrub: remove local copy of csum_size from
 context
Thread-Index: AQHWrf/wESuVFAsVj0qQPYRxNLhoDw==
Date:   Thu, 29 Oct 2020 15:01:20 +0000
Message-ID: <SN4PR0401MB3598D99BA14332CC39B986DE9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1603981452.git.dsterba@suse.com>
 <7a311427bcb433f5ae9f84f4e07d3653e1518b1f.1603981453.git.dsterba@suse.com>
 <SN4PR0401MB359801870FB4E1381BE436DB9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201029145412.GL6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7dc1c1df-df2c-497b-5c34-08d87c1b7eba
x-ms-traffictypediagnostic: SN6PR04MB4605:
x-microsoft-antispam-prvs: <SN6PR04MB4605AA76820F8D6E1F45B1259B140@SN6PR04MB4605.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlgSQhelzvQiU4t/a37nsg8V9iA472OKWI6xxztZSsCFEZJkaVKBPL9YpHVVdyeKd1gswnQ01XDE8NR8vevYGw5ngRX84zvW86vMl0bQiVUn0mWPgGYNuTD5eBHwBN9G+MgCJosbntgVbDuQA84LAY9HYPzZLEeMH1ZUPsZK2DDq9cQbftVjvDUizJ8Fc640cVQHlTxCdRR+WR3RtzrHGphpyiQbFZiOuoAHUeCi0m7D8X/H0JIGr4WzzQLoRUMNCMVusfngJzOknQ8VJl1cQXa0dqEMpLxhLX9kRaudKNPdtMfmS0zeMBtVbl8skJPq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(7696005)(8936002)(52536014)(71200400001)(9686003)(478600001)(86362001)(33656002)(53546011)(6916009)(6506007)(5660300002)(4744005)(83380400001)(186003)(26005)(66446008)(4326008)(66556008)(2906002)(316002)(66476007)(66946007)(55016002)(64756008)(8676002)(91956017)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9vQaEKoxD96c1W5PNSCXZ87nFUYBZ7MGZSIvpCgZ+U1odGShCcYW6vbGo/1ZggqxKzFMYAnLpSCwHyPab4lqXtlgi5JihSvdk6Do/9xkX7rEb1BIolRPAbtpwpadANo4S24eBDWL1U5VFc9+TrA3e/5PsG3IQBqSb4XE8tV5Zw4/bJZgsBVwpgD7EH6r/sUok8djtBlOEFh/yc1Zz1NtAcLgbSyMrJzP098o29eL6ulY0PUnX0dwOW5lbb1NdBff7UC2q8hhj8aryONWf68NVcWZqPmdAvQ6w5alEwqLTBXxGSAB2kNvjWhgL89JMF4GghIWDWyEVeMND1K75plfS+B5oauNuiKapJi8KkLTIY+mnMAlrCKQWwld0WrndUZEMsYFh7JwMeQX7P03RAFpm968Iv4z1yYK34jNvATDQh8rkBtq7HWx0xsUX66dpF80H9+aTTPEsQpG8iS7xiKXhSlbnxzkAz3biu9mr76Ejry/BlYngsSiORCuNchfkFxuMZGtaG7BSNMIKShev3NuwJ2Gm1/vW+fITCdVgkWEsEIhUBxxDiAVHbwHx2Rq6cCNJib4zbQl0pnu8dJn4Y4jf/4PLg9uJfD9AolnW1FbCtC9aUDoapK5yhJCd27sr85FljYlmtb0E/mV757zMAasFQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc1c1df-df2c-497b-5c34-08d87c1b7eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 15:01:20.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WxkcDTm+aodI/OkBVimcVjy8UuXjsyi9Es04GaHIYpDavVz/FOamJUC1pHVV8Z+yQ9RTB2FgP9pk1qn5suevuEdaIWt7DVXtkH6df+3Pv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4605
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/10/2020 15:55, David Sterba wrote:=0A=
> One logical thing per patch: first is removing function local variables, =
second=0A=
> is removing a member from integrity checker state and it's use, and the t=
hird=0A=
> is removing member for scrub context.  They're split for ease of review.=
=0A=
> =0A=
=0A=
Right then, apart from the typo in 8/10's commit message.=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
