Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F03204C7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgFWIeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 04:34:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39834 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgFWIet (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 04:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592901288; x=1624437288;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DsRXQIQ5VzspXNkMvBeOcWoO6XekUhNCYelOjDlps6Y51VKs5VJaWvK5
   Uu+LmMxbc4YXHlpKNkOsYMx9o1yeogBL8cSxC9gQwZrlWRJNfCPqLtir4
   0Ood+3gFJXG2IbF+8J4I6B+doBHLXad87m2KepBviGoZPRDO7p9Dun7yn
   /P863sYjRrlW0CctIJo4VaeIeO+mQocXsdxqbMs591GRc1r7dUG26JBHd
   1wrURwh2DtxR41CmRVp/sxXwFUm6sPAKMzSrdBt3CD3RvZjbU2fjkWcJe
   OgWhIau9tD55+FJmF7p2/v5IGyC7R3MQv1JSdjm3VVtSSMcuQBf+s68s4
   Q==;
IronPort-SDR: TPrAwSDk1GqS+P+x3vXcToZQ33Wv3KsMFu08bjJV66k38/GzaSQN06sYad53nxL3PxUs75xV6/
 15TLbSrZmmsRQXSSsBEfvEm4cDKpRwZvCOZVljgVN7QZdGvEtWzMFWP6DpVsgWeTZSSqrOPvrS
 uz/KDEYSPMBC3qGgk2885UMehp0KJ//KezKLM8Y1tOsbUw5yL5sfwrEqTJZ5SB1fENaqTzfNRu
 qhRI4JGAliHaBrrVegE34j+tQMpXCPCMtaI3Ss7h7D4RmsvboV03IV3cyGklkC15/ILKh4acny
 /p0=
X-IronPort-AV: E=Sophos;i="5.75,270,1589212800"; 
   d="scan'208";a="140921854"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 16:34:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Raj6VoGbtq+7Gbp918ehzPhWeSzF7EkgnrXRLuq+2K380dFIcojzgLQ0kgB8nnMvKmltlces71TBhaCG7Igq+lnr8gf3W5YrSyRv51whlm1gAM4JN4wX106h4YzSV7entZ+AbsYm0WWCMnzgBOwS/4yoX7rL09nKO0jvoPFC52nn4w423X4ubEh2qSkSkGXngvRQE5KNxa9u1eLVovy7h4CUZkxGvjSxbTR5QPMe9hMBAfnTgCcEWovrgw7+72VYfVIhLtUtkAutmTPgbXmntqEFv56hSEF1bqIqEqiT2vf9bCnY8uPG+hDNP2AxmXYL6c3mYfq2l9scPKJM+KujcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ykdn8MS1hwNsG5aTNMrKjEgPI8MoiM1AGRdj7Lw3+0SbplMwRQV8phbiIstpdAWN82lYfgf3uUkwHblWA1wWUX3JU5JOzgGKpuy6SN4yld68LB1pPdZWhVto3j/g+lcmrOn9GECGOzaInXIt2WGxtOmlNKHsAJNhEPkBoBhyhwcbUddTqNhB0JVKUVCERavgnB5IjxT6gLY/GLnL0aVETRmMjIQFUbo55Z4/O+PDI9RdLh1+Xjq16xd7fwwDFFLaQ/k7OtuAX3JSA+KdIKnOj/sn+9e5X0FHY2ntX+sxQRfZPZG9LP9vAoyKJsk5HIfBqWk2dHdpS3Vnt6p//rF9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hQ8tj6x1eHLk6QWHDm2YCFFzVhtkEGsb/FTDhrxMaox+Bc79x9AnH5n+gv2Yz5rhLGUeFzpaguUiuM8w/drdHTqTFy/bsc86J+Rjhc3HF/E+y+tsHlGCDkSZ5CkzEV1gaDRve7dt0OP90XUqGd7PhrpmpJgvyYtai2VKCXZALPI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 08:34:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 08:34:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Topic: [PATCH v4 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Index: AQHWSR4lPNaufSY3WEGLlNOGkfJjrQ==
Date:   Tue, 23 Jun 2020 08:34:47 +0000
Message-ID: <SN4PR0401MB35989742962E952C5922F8819B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200623052112.198682-1-wqu@suse.com>
 <20200623052112.198682-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73a0e786-5ba4-4708-ef0b-08d8175049a5
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677D663C9EB456D451A7ABB9B940@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiwHLSUNVDML/1d3XaIoE8BfSBFT0OpoLbBtnvnn4G0aBXXV1r6qEwTgcOIMswh4Xn7ie0wO/fa36HscvgC9NaQZKgYIPJNe6+iFGNQxgxGQ4lg/Xv5F6NPITHdtgr7o7fkyw7M4tsnxpfZ4F3EWeCNE68DAzhSZQ9IEX8MJ3VOOy/GUp4VWHSBNMdv/8bEsofeTWx+DmIlTi5yqci9TkCtCTlENfV7cxriV1DsyqKJOOcR73+fA4YJ5a5SKIvM5nCQEnzmxPVGGmQL+J96uQzOff51P9r2az/GL42h0CCk9o/W6FFdhlY8mdGn5YAlHVnGJFehskY6FbYMEfTEtcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(316002)(26005)(110136005)(19618925003)(186003)(2906002)(478600001)(52536014)(66446008)(66946007)(64756008)(66476007)(9686003)(66556008)(76116006)(91956017)(4270600006)(8936002)(5660300002)(7696005)(86362001)(55016002)(71200400001)(33656002)(6506007)(8676002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: C4JXx3cAID/791VzV9MNi92aHV89DdoTpjfwclmbNWRsJ9cYFdWd3kzj+FfmhId095Wog5bDLPbEmZdamAwSRzt9ARDxLk77VN4UHBybSFrTs4sIXnCCS8wbF7LRT/hxW34Qs0qwq6aK2WVGh6ztBS4yQShlyht3wkl1nM4+cWdOhCnclqr7O/wkK8BbppC28wEXbqLgotFuEBVSLclFKuVYnNMaSW5oJAw2dzEeL7RPoDiiKdnX9B1ueCZbBbFsY0rs3zWntyUChzw7hm9mPEXRbx6mi00OPfYJgnk5HXVUIPDi/fbfwcx0/BmjLO2vt8KvR0Pn5WjuOkhSLCevbB6B79C1ZrfkJrL+GRApAASngg0nIyUqFCkSVtnENNJinSpXwU1SGtEyyCT7pnvTBjSMQMQZjcIux1Aoj9wOr39GCmMMAhM/JRhxUvMsncyjgQrMK5bZItjCMuXnzdKbhbcj+9FPJzFhmmzy+7LZ/+BiUMXRgAyEtDImYD95kApA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a0e786-5ba4-4708-ef0b-08d8175049a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 08:34:47.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5q5I8amQBs6dWzMFLs7QcB2rv4uaTlGTvz14xjp9aSFoEYZZPmD1OQzG8CVUpqbKyExi9ZysXasucfGWegBg2MZoZ3ZWTiGZL8GFWjn2I8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
