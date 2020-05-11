Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110081CDD73
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgEKOlv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 10:41:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65051 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgEKOlu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 10:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589208110; x=1620744110;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dSyuYebvdzPn5fkUwOdEweMNoXBWNiBRJH0Ig0f+otc=;
  b=KDD41bBt3mSk6tgB88EvaociAGzvv9JQeUinmBDjklZ7PZKjgQXst70c
   ZuwxDC0IF8flGViONhP1Xk4kuqGQDT9KGqeNzXGCf8sq/Z+wb1nczfCiT
   le+ISgdVxw0qGCqaxGdq97Hpxa2Slry9DHNc1M4B0ijF8IDDJ7wnwJoNR
   hLl/3Z2BHlu0E6si258g8MS7E/7Uj6Blfs7PZqSDwMtbYWCL87iBg+0+s
   vdGS2BdWtt1wcPomxwn35ltN0lh/BfZu/4khNJMYoSS+jQtexGo5fOZNu
   UgZgc+vCezC/2/c5NF0iIMTKZkq+qpetpL3o570oCWTPxzPeH4x7a7AaR
   w==;
IronPort-SDR: Uzx6+QaguTBURdIkU3Hw8vNzdS8KWZy7W4ubQBHgM5KhXZReVuVYt7722g6RrgH7qUouHy5c43
 oS9cg8z8PGzgodRa/lqTc2UWFhYGtENV9V/xfE60SpOBy5xNNcSqIMIoHgQPVHZE99hnm5c63/
 pCn2aOxbPUpzGFQopsMn9oBAzMu3K58pEQfwxAJYxWLUXh/ujDZ9xhTDcmWOQPO99mnylgg2sx
 g6kk3IWem27llIDfQAJrfQj9EOqayNVXHKTUogklbbL5fqARu10wGbOMi1C1NS1Uexi36izkn2
 AI4=
X-IronPort-AV: E=Sophos;i="5.73,380,1583164800"; 
   d="scan'208";a="137746633"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2020 22:41:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaYa4gnRKIl8LlTkIlV8pXdJoLNOp2De/yQ6T90bJXP5Tb0s65QQ5/CqtUsbZ+gowNFPN64RBhfjErP6+IHsPz5hQLo/jGOvhkz93Oj6BSdInaS4tUbzr0J4zjV/7OntiYWkhdktaN5XAiI4xr48d4t8MxYOlrtedbbibJkNoaM0tM9bzKHgL0L1rTitQGsOC1OUR/G95b2EiKYvZ40SxVqwU3dd3Vb1REiP6Mtsa4ZU3DNO35y/+ENfEEfqdgcl5Ig4liToUxMlbdWCuoiTkHPoIq3qPWTFVxXWdo+nIhFjS9KYwCr3LLvOtE50HyqNaYzbl+kQ/N2yH/mFhC8UnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnttXheug1IF2Fbb6AilQ0eSs8bY1QxF3tx/jAFqLZ8=;
 b=J7snLqAeQMUE1EFSg5T0ZSVCsI4iYumAFJS46EZgxm2KBgDFIwpYkxFiOFCtrgWIqbCiY90t3LXkCAl7AarK8H6NWGGaVjPRr8oKysl42WgBX7ndpRX0lALVU0p3A+g9PGa+PmaO1D4Ndi0gLBv7LxhlMYX4eAs1xJYIRqQLfmTset4WH1LLOHH14kCA6XpmRsVo2xtmyK6ezVsWLnTVyI7FSt3MWhHRSS4naaDHS4LImpFEzfcsFPq7lIN27ixh6PSmyM+rlN9cDYFrK9aEzl5xwgO1kyq7SC2sIAQam+uQikQENapQZkGtf5KpEVAvRX6SV/sR/fHi02L91sInUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnttXheug1IF2Fbb6AilQ0eSs8bY1QxF3tx/jAFqLZ8=;
 b=NfjFm3B2ryqxwYAmSbq465jM+m9wGIphixggmtRALssryDQYOgLTfLBwcTm0d2iZBn4ZVC9aRK30dxqTcDmXm5dZCi2j3BKeiwqi6Rc/yWnzhrSU44wc2tmN+Vv6KGKztIyfaIJOgUmP5R1syWehUpJG0pyPSGmxIWfcVVcSX5U=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Mon, 11 May
 2020 14:41:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 14:41:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/19] btrfs: drop eb parameter from set/get token helpers
Thread-Topic: [PATCH 02/19] btrfs: drop eb parameter from set/get token
 helpers
Thread-Index: AQHWJKz0ZuoijrluZEi3YBtV6S+Efg==
Date:   Mon, 11 May 2020 14:41:41 +0000
Message-ID: <SN4PR0401MB35984ED6CA4231FCBBE1EDB19BA10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <b8b135176911726d988ea5f686b93fbd351e47e2.1588853772.git.dsterba@suse.com>
 <SN4PR0401MB3598EFE7FF6F223E36404FA19BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200511130237.GP18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89052024-9625-4171-66a8-08d7f5b96bbc
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB366255369E35C66553C24D3C9BA10@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLrlCUtRGyHTcaW7Wj4Vlx8RE+y29ltCiI7MlkArxzhr1/kScoNWAH4bencOtgiZbHU1IPpojGy34FpkKPafZ6pT8UOc84n9LFcrckQ1tQWPUVYRtgzXWJXPRWKSi18uEs2d2zTuPt4/8cNHxpapqDLxZ9Uhd6NNYLZTOGh5+b5H+k2kXTwODF01QnypycDXe3y3QQ8JO3fq51sz5Xs/f9AfDj6WfJd6hEEgJFNEtnmUvOL1v3TksmD5yGhh3wmUyVaYDxTIFmEIs2mYCXBUF/5mKQBsDuCW/8iVvDjSUK0TtLt7gY0Rm7IX6z/C3Urh6KyGtH56Xhxb4XuUkiP8DwlqVhqOXEuwGMXiSn8ERPXXR1yQn9lhTUCRUXFnt9hc6pMwMGtjbRlHiZHhE/M/9NCVAkC/bODiDCYzzl3/9Eb+JAlKXMEALtcRIzccdNb+6gYCzO9cVgAFK3Oag+R3ADLacs3AZskxxfbRlxfmwrXSAWkXr8pRI2Zcsgdvnajv7fQCNDekdSsAjsSXbEOocg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(33430700001)(4744005)(8676002)(5660300002)(33440700001)(66556008)(66946007)(66476007)(91956017)(76116006)(66446008)(7696005)(64756008)(4326008)(478600001)(186003)(52536014)(2906002)(53546011)(33656002)(55016002)(8936002)(86362001)(26005)(6506007)(71200400001)(9686003)(54906003)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: L6L/rgFk7zGfrrmzOJCN/ET+YTTdmxx+kmUkRu+nS8BfJwUbt3/EsIFeLoP6OED3cgaqhT8q/fd78pt7cxdBY9S4EHx2eFG7f8PXjOiEDe4NMi+PZgCiITwTdG1BmYlCwKXCWJIDKxqY7qEMPCkxlaq9nPLKCgvh7J3RzP1BUPZgcNmpKkp7oJImGu+mlqba72cj+n57bMwiHZEXjDEiFTwo2COdWKRReNNM/NG7SZweRKsoohUwwcRR7UWd5vM/ZeunPYxy63Ds/OgEFAUOXnHzjUjGmrwfjqAhXKPBKAY/XLPupdgrDyHic3zedv0BVGQ8FJ+vnZZAXM9XHc7ubeD53GJv0VYDMiGr09HTDzy2Mc3Gloee6ZmOcVKkegOMWJjFVBsOO6FNJaGI6FHCzIW8SXalLHl1+z7Kj4SIeSn+mk1WFoTfi/mUHUDL6MR0cRJ9EIEehRDK7FeriP21gldE8PGFoPh/DzVUGQdbiaAciENtntGpOFnWAQQTwOim
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89052024-9625-4171-66a8-08d7f5b96bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 14:41:42.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qNADKQoOcyZMeyVMIL7pj3VKKjKp0B1jVDLG8mM84QKO4D0GfTWQ75MxbtymREcD5Niob3hqLZWcqxEXXcuEyTN3nT0vsQeCItvi0oTQ4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/05/2020 15:03, David Sterba wrote:=0A=
> On Fri, May 08, 2020 at 12:09:15PM +0000, Johannes Thumshirn wrote:=0A=
>> On 07/05/2020 22:20, David Sterba wrote:=0A=
>>> +		push_space =3D push_space - btrfs_token_item_size(&token, item);=0A=
>>=0A=
>> Nit: push_space -=3D btrfs_token_item_size(&token, item);=0A=
> =0A=
> Yeah it could be done that way but I'd rather avoid mixing such small=0A=
> fixups to a patch that's otherwise a mechanical change.=0A=
> =0A=
=0A=
Fair enough=0A=
