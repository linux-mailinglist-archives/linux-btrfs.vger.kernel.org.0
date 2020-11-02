Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3402A2DCA
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKBPMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 10:12:44 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7440 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKBPMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 10:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604329963; x=1635865963;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=go4yVwVC5itVL5lC1yYQFIQ9vWWH475JCXx0KXGKj60=;
  b=Pc30wFMMiiiWV+KLbXhgNhBk5fgQUjbq9wMRSGFVtEik1tTxklCWX1GS
   IDhrn+NWaBew3GC7jJOezdewYxE4dcRXJy1aDuHrczQNsbhUUnod8aOnE
   ns/eS5bp3PARNJq5gSqRQgfLINMFAcjzJdwaJ3qjSA4BinVNrOfP5VWuA
   aSlRCLZ2oswnlGRnip4lkPvyoucoW+YIIEr33pTMLB5H4qRZVJgCzfm4c
   R3+1Syr6xXkEdi+WaCRvsuQllxt0XcCG63nfB4rqo9T+gxZ5nxyvkHKgE
   6BAFqJIabZZQF6sCy0SrMYpl80frU6zjp5X3BxVGEl+MlqwczpA1M2GtU
   g==;
IronPort-SDR: kbYvLONaPo7Hqq5qmWHSJF2etAqUnTk8DucGqdteJg+exIIHycaujGKIFReyfwWVvOu1IIAQSZ
 R75i7UIZ25PI2RV5uA1uBbMoFMsDxTXKEr7eLhem7u3VyXUe/Tfap8pSMoPas/B96RzmDeDwEj
 +nJFoMsVY+GO9Vp+VAasxJaC04ZWTcMHCKIxaOlpx5CghyDS6QwFeAIQlxTJOApNdO2aQqMNtE
 5RQfX6JUsDUPEZouqOUKTGqKGJM16QyWDGN2hCRCpFfcqE+pdM0dSde8ryXUVwJsFytePuSDLm
 bwM=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="151459005"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 23:12:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZNwxScC3IxRqCyz16BvAWJYFRYGaBbXdHBKMu6rnT+8Qo/88v4JnK76n3fbNGHGF2rH1cplfedKI3CH3P1PaN7xzK74LeQ+24ajiXo1iqG3KpVtYe83svJliVxMaJkqge3tptaDae+/CM9qbaL7p3OymPVtg7aCaJVhu+wYmC+CcodJg9Sh11w63pb2zzP2wlBoAcn7F75hri3lFMJpE5VeAfz1WK5z66wKfS0zpOk3y1Ou5lf0sHO1IQ/rmvvKzk8tO+yz6s+SI+Mspxhs7ZM6x+3MwLzfvznez3qNygHRuY/8S8aK1G3h6GwmIdLZzKzdQCYe3HoSSrg3ZwF0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go4yVwVC5itVL5lC1yYQFIQ9vWWH475JCXx0KXGKj60=;
 b=L3FxWmRJS074IZ/TIeOuXRVTER+WQoC/bCxvE+362JefgVQ1U4CSvPW785TrzNITA/nx3+t3mONz2a8TNf3MWPnxinhxDg/rdvsPf45Hx+QaVZi5moYP1/OLa4yr7xBo5CtAb3v5oH1h/i1cO2mDXlpg0WR1CxX3i7gzHO/s+6kwP6/+NreYZEgD8C1RY6SEuqbUHvnxZ3YWaqc5NQ5SFeSDZr1DaZTmtjBKTXJO6981HRv592upSdtH3dxrqdrT3CCxBsXXh+x96TXrn5JaMbymt3ZRfS+dv/po7DoZYqrwqhVRBerKNlbNFuMmItCYwlo49UxQs7BQdmlQ7GprMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go4yVwVC5itVL5lC1yYQFIQ9vWWH475JCXx0KXGKj60=;
 b=Sor+cwmJrJ6s4GbQNE2bWWa7Y9z/nqRs80rdJHhSNHgvP4MuSII2uW1feRlIFZlog3JqAu0NTHeVuGIaXBN8EHqVfjuNoJht8dV8sqAYcGURAASgXUeRwtjgEfbwHWZ+KHlhMYzo7FermwVYlKukjFQWVN9m+2tIVfF6R08zi68=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7323.namprd04.prod.outlook.com
 (2603:10b6:806:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 15:12:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 15:12:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from
 fs_info
Thread-Topic: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from
 fs_info
Thread-Index: AQHWrf/ka6/Wfff0gEGO3vs5flmt6w==
Date:   Mon, 2 Nov 2020 15:12:41 +0000
Message-ID: <SN4PR0401MB359892013BCB4566671774519B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1603981452.git.dsterba@suse.com>
 <b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com>
 <5d586f76-7cad-b7be-60d3-44c8d3b67623@gmx.com>
 <c798fbcc-c7e9-fca6-992b-bd006d6a61b4@gmx.com>
 <SN4PR0401MB3598B9DAD09F08946CBF6C3E9B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201102150851.GD6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9eb8232f-49b8-42d9-6fe0-08d87f41be34
x-ms-traffictypediagnostic: SA0PR04MB7323:
x-microsoft-antispam-prvs: <SA0PR04MB7323393106B47F3BACE906779B100@SA0PR04MB7323.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eq3IivlhJhm+ayR2vQuJqGd6KBecvxgJj+3qge/XpkV0eltKbPABwF6QFS8nvAi85Anz62qm3+7KQpatMTmXTmll0c6jZmdkEvB5Ic4OoyeLdAN6jjySlyZThebp1xi3Kwil1+C9XoSyBcr5bXypyJP7I2COPRqJw/xqw05ia8Xk4mJfrBa6vxB8lWg/l+RvR0FicMlkeujnkSnhzg5zsMjm9Cb8uhLdryW++qyjo5zzmGYM275jIngKEDjSdoKJo5sTUJB1jIHy92lnnFyGQhP63RfPc0Nrp71XzvzmYIbaaeCm2/v3BCuQ/d6UWs23T0z+il+BPY61S98ipo/Kkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(4326008)(66556008)(66446008)(52536014)(54906003)(5660300002)(8676002)(86362001)(6506007)(558084003)(53546011)(7696005)(2906002)(26005)(9686003)(33656002)(8936002)(55016002)(66946007)(76116006)(316002)(186003)(91956017)(478600001)(71200400001)(6916009)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lSR0YIvlyrIgqDdHsaK+HW2wktjEl60vewTFKlZnSN7A7dh5dYucbaldokUZhtCkakoJ5v6q/JOQSjookV1UzLFdbMS9DO8/KWV97Zan3eGrm4jQcQW+wXi/egShOvcJaTH7AyRZvOE8nve/DLu87iVeOvl3RuD3qZjvIuaCM8wSNS9lV7Ueqx47AX3TjcuZ6x6B+gFJXi/kXN7vNv5Jgj1rbJc40AK8bn5/ds7boyN8qsiU3yIkcG8TXBx/zuBawimcQiOhgTJtLpokkR8I8BIKXbPQQbpf3WOImIAJtRvhYg4pAmnXeCIwOLoGOPIBF8w90olN3RNxep3Tq3ZAPV+pjp7fUBA+198GdCg3SWnxZ1079/xg18VgM17tFEZJSuEZOlwD53E4rTZUjByEwn8nBfjd6H+6fWk42ChiHBZOqQyvJDhq+i6VT9PXWZuiAlMianOHy0fed/txPpWcU+Gs4WEGaBm9kiVj5w/K9PzWKbh12HNZ8dJpZdUDbr0uwYzdYIvS+QfeC8VFc/1e9QoItKhuT75fVaTl2kszk4WzJzMyQ8mOT5/M9XLCRM3xmpoNZVG3abMffpZZaIrfAmKxNlHrpUSD337yqBOkU3BwWqEiM4QEc63ZS8A4os4YpKy+JzCIiQugpxekWMBbHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb8232f-49b8-42d9-6fe0-08d87f41be34
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 15:12:41.2671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fg+q/Gqj7526GOzBhrITRun2FOMXcMQPM3b8w7ttP0+a2giuBDUKzIlTE5Etw74kGo+rSwPX2MXo3REfRAU9XC93jRTvZa1h7lcqVMptNow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7323
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/11/2020 16:10, David Sterba wrote:=0A=
> As the value is calculated only once for the whole filesystem lifetime,=
=0A=
> I'm not concerned about speed but readability.=0A=
> =0A=
=0A=
I wonder if a plain 9 with a comment isn't the most readable? ilog2() is pr=
etty=0A=
readable as well though.=0A=
