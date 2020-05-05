Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA01C5170
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEI7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 04:59:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30199 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEI7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 04:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588669197; x=1620205197;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M2ilOFbhRr+zNJbrCWSGbK9loZzijxvYTSfsQ+b8KSc=;
  b=pLJghDR2/tQa3M7RbA9eWnFj4+TzLXHSjD/zwRH9yfc5gJcIJR5AC5ct
   qV0fVLeN6joMUofwkWJdoJwq+CL8ErmaIbrceiMv/jIL1DXcN+T8Bj8hI
   9PGdyOCqtpS6fTP0Gy9BYo5BEzuvCiL3uCtO4zVevUj6sq7bcbXJ1Vzkg
   yrGWkZLWs8IGluw4N2CVasxJGY6kBgoWLewzLCJAz0ro/gMUwWVdKDEKF
   u73JVSyr7unolOz5fGwH8vQbY8JfVjXyGsPQJbduYeduL7JP+CH1VlM0b
   LOej7BMB44OTgMLhBrt7aimbTaHOn2RSSIf+CD3i58PMN/OVFecpUbXTZ
   g==;
IronPort-SDR: vfHUjHvd9SlQCiaHEq69xzJ/VHHBkpaKibVHtKO0JukLCMh7HLX0WdVXTTWcSlRqSO5h8LmrlR
 DDTRHEh9CdmWa3j6oHVdhABQ/IHn2VhvIQoRtOVA8mJCBcq2Y9KqnuhfgoqSCZshUpMntCoKwg
 tIpvtWeqmwHqShLe+9TlUDAIL6tTrBS/B3Ki+IW175rVfxFOmUCJ0i7og9xKE0cGaB7QZSNLod
 MOrN0GluKaYv4z/9j4hYoI6dd/dOH0cVVAMrDWg9BPECL7eO9ed5tmzaQZAJxp+VnuoPzd5mfz
 sP0=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="239561361"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 16:59:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAMssQuDQ6tXEXTrbdSdyThyVb+lOYOWBmrKDIspVywdQcYA8n+ztACAHr+lQqwecXYBitGwACBrq4Hlxez9vbWXG7PkxZhG5ehzQ6c6TQ2uhpKBPl3oLKdpYuApOWyj/olGkjk/I3gKLnNnpPAvA3t2Qo8j8NektCIDMu8c223rnEUST5un57xLKZ1SlIxjF+rSAMsf+scG7X1cJCb0phob1wfi/sG7JZGODqvKzXHHUO5G8DDduzOsuevKoeKx6KkZR5GQzCPH33brktWJOE/WmmrsY5X95TCx3nFnKE9kGu6ma5bOfi8lHhQdU34efFs2mCd3jCgKN/52b+04bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ilOFbhRr+zNJbrCWSGbK9loZzijxvYTSfsQ+b8KSc=;
 b=J7lyIvsiIAjyXokam4PEY+YvQuQ4C4CinqBajEJyjomJ5u/kRAt34/VLydvLRieKwtTMk57QGrd/caf+9JH183Ija98FDfTOaGTjGI/A/ExYhvCtBJqm6owy6EbqjI4m9beUjk5ezwZu9KLaYr8puHJcICmjInvuMhT6+77vsCPGXawMuOTRT5g+zTj5LYIStsTypOlEwsUCe90Jnt2FW5BCx406NCcADqzmx+FewaY4f4wXoEg8iaMtn8dl5CNWVrvs8XKXIdVLp5pnYobBTlmg0MPIA9uiwNtx1EFpLq2Q2et+LNmy4Un8hPrTrWbCf6oL9V2F029McwXZSQ0HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ilOFbhRr+zNJbrCWSGbK9loZzijxvYTSfsQ+b8KSc=;
 b=AO4ckNjaf21I0//afKIrQSWf2YPYB5XBajJJz521fvsZxqPXhG0tT/CAPJmMNJDIUEZ53/FjFbp0zLIK1qjcIBcnnokNg+6i1Qc4Badjei8ivbjezesgNTogca61cmhnGbJFXqlLBtlIurvSkBWxhkspMQy8Ao/z/vqdFvcPVYg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3614.namprd04.prod.outlook.com
 (2603:10b6:803:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 5 May
 2020 08:59:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 08:59:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 4/7] btrfs: block-group: Refactor how we insert a block
 group item
Thread-Topic: [PATCH v4 4/7] btrfs: block-group: Refactor how we insert a
 block group item
Thread-Index: AQHWIm/xuboJyeFmik6g4zbFQW+d0A==
Date:   Tue, 5 May 2020 08:59:14 +0000
Message-ID: <SN4PR0401MB3598A87323881359B90EBCE69BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200504235825.4199-1-wqu@suse.com>
 <20200504235825.4199-5-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1005d290-fae2-4afb-a502-08d7f0d295cd
x-ms-traffictypediagnostic: SN4PR0401MB3614:
x-microsoft-antispam-prvs: <SN4PR0401MB3614F08971907E6178D1DEB09BA70@SN4PR0401MB3614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iB6XgVCeGPMIhBrD9QJllAJGa3TxrS1sh2oxjAzvy7ketWNP4/0dSwDJY8YaDizkdPPBq6gDYZGVFswHltz5GFGB3KBCEPKh8qTshVle16oK8XJ/ds7ZEc5IvhDUu51Ro5O2Y7QB2/CoHZvnqiXgKfGZyWB5LGoe3gJGidE3mgRQpA+yTJ1+ygOBxAYGUcEStNZ5rsY9Cvz93E7lCfRWo/J7DDmO+wV4MhjTPgpziToKq7k5qb1eKNJ2wlt7esjr27EGAeRorFCVbWxTgFsFw6na/r+DUQ45NsBeBW846ejj4jjNnAJt2J+Dbln4CKI0NFZXlqzoGSvAOdb995YmEFp3o4ZBKrTvnMqYmPdCScEsXUJLkoUdg7FWyHzYV3o1NE75LY8OY5GnPnVOo5cE348tdYUFRB5v+hpVVeSlD94gPZp9blmrwbgcE+AJ++Fx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(4270600006)(26005)(558084003)(66446008)(64756008)(66556008)(66946007)(66476007)(478600001)(6506007)(76116006)(91956017)(7696005)(2906002)(33656002)(186003)(71200400001)(9686003)(86362001)(55016002)(52536014)(110136005)(8936002)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: L5lYNyorcYYFsynGxcpoWmYhGmf3wguJwsAAVKH4FMUNHBi16UVJeQ4XKqRe9onMgH9wyolO3dmSD/QfoFCOII91xTYO1lmwUJ9zSoF8/ztdJ0MuhgR9dozUONgPoHGVu4R3VY8YDWTOgUGemEna9oXnToI/kP+7npMkpS7OkpXLR6bOrATYmz2fFsg/IpVp3xdBCUGeLJ4ATV4rnqzqvhQF1CLNEPyQiFW5Ws7/wuvvthgyAu7LEc0/tfweJM/rdL4Ug6ypExgJ6nFzoypEkkwIg/nchB+ZtVy7JYGv/RJcMAqrV8xIRmuunq8Ez6gk/0wi2Op02p0NpjyVfubp2rQty/w4Ucmt4F0/juK04D2T3OMVO/WcyzwUmkkFWJ4kJiVTD1MdLAzBsUHVPXgKuUTsoHWXsth1Jx+wXnXqjUPKKgdAD8saIsxNGcATWqIsQhsWibe6JYXHuH+XDEweBeLuCz7goAlu6NLfLmGZHMr6GL81LsqAaeljMsyFN5hhAjKRbvPAI3xAqkeWwvGJyLJk1K9LHi035Go3y3oEVX2jMr1/Lse3cGcj/Vxyf4GAFn2rTNRXAjVjZY+a50cNJsYNTk/iXtHp67KLrhW0YTa2gDFiwdstWeSkD4wnkFGydBJNKSUa0LbFh/tzYZKIS1Ccpd8uNkQVRfcAVf/Zl66llaI6/zAwTAu+mUO9g4UjaoF/AiNlJiB4tGEdU1k/kyveSCwFVLqhe32TC7hQoNrhIp/+87/we4+PUY06Rsmhzq7NfWJ+UUlaUvFQf4/vlQeDhi9NE3jyipJBDgmyBMw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1005d290-fae2-4afb-a502-08d7f0d295cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 08:59:14.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXKybpD6x7RSwPdzRQ+6Bz/ap+UGyx0R0n4+82oAF44kneBKb1rnwMmOy2PgFaY+2LqkwCP05rYEkZEKIClbz7zNGDTlYOLNgkK2kfistrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3614
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good and usfull on its own as well IMHO,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
