Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C832578E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaMDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:03:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43469 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaMDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598875421; x=1630411421;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sHEVHjW3NKtYyWwEpcHkK9jwBpCxCqm0OiMf5LcZ/Bc=;
  b=VF1dx7m+XNCwaDwEnluZ4G/USDkRwZlC12b9w50PurlKO3UESlGdSMtQ
   yvAvyk2F/Exv8Tj8dJ8SrroQWc9c2RbgBTTNqS2miQ/iW93mdiNvmEXXe
   uX1f4wA+0PsUTuJ3y/WWOhVNFug4m+ulFLWjs4JZ7HUShPaN00ts+sLHf
   UlHqOdgZuDTHqBhkBdx+AejuLmhBBI6kKhP84hsvRSXJHxQ5GFR93StOW
   J6Lt50XBzeZBB4fWi5oC7LUAK6d5TM7hdvJkNyZyEcDwuM69gi1EyB2aE
   ir0awLjxqXgSrmqqD6YFC4WLUyYwofGvKGpky2WRiER9oNx2rHiAayhhj
   A==;
IronPort-SDR: hS9UJRBzkkiAqe6+UUfhcE0NO1soVNzHo+QwFXmXEKy2WsqIVfLXxO/GRGwX5z0JaRKlnK7eSF
 Actq7/wICbkcEUVEVKPii/jbfYZRZjUrwPf6fwXVLrgktMv0S68lS+GagH0QN5971NfKRwAor4
 XwPlfA4hizqjxmSnIBAu5+NSTe8pKjIXfyoquAy57nDrx0E5F+LNo/sFnPXKYtvd8mPy3gi3va
 rQLKvkpmvBkOttUsafTS3SF0WYvfoAvccst1GPv5nq/z0pu5+m8iZfTQ7LFfxG8FMPGecNfxb+
 oDs=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="255742268"
Received: from mail-bn8nam08lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 20:03:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpNd+La2c5Ncl8/aWgnKDHim8GVw9+/qXlTuxv2C1cmVIm0b2b4j+Ebsox9d/BcyWpul1uwnV9pX5TT2CIZvXairGhnrtDh7PC/KLyCPXyaKei7h4+ymlRCWfNfqRkKRjfYIGxj79Bu3RCEeyhOrt41KKR/o14jkUJsw5YccZKiWP/N3Wzt5G6GN3+5k0ug1NW51nfR1rvCdM666d7DrAyicIzUxQHQyUfYCSByBw0KxAK02rP+PumVd0C6zDUg88Mrshh1XgmWuTuMzMW/WiSZxF1ytAw6pIehTNpYS9iJubUp+70yvCHDr0jAY27eITAX610gqfbu1aFzjMCWs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHEVHjW3NKtYyWwEpcHkK9jwBpCxCqm0OiMf5LcZ/Bc=;
 b=nSK8eI/drr1xDMT/VmBeCWK1SuADC3k98tz1XHi+YdBv9o9YKaVwGsEnw2neOaPLErTBZMtFCf9heLkGPAXFOFVTzvkJzJUYnw5EV0gab1fjhMdw2OTz2K7cV+SUxmIjFJxMDMl4oxdy0bwVTpOdOayu5QQ/d4JXbvVoQmoeSRaxlDaNkSBUZCGmCAKh1IxfOFfP/+seBXiFCGW+6ReivP8PtVu93FaKMj5Vjkzj0p8K5zsKa1J67q41qwXS20wfqKKCuIUJTIxVKjuVkGnz/VgpNpRav176ITWGvINd384mVKys7rNGh1tar0Up0kIK6gp9nQ+jNM/hSVdnyMVIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHEVHjW3NKtYyWwEpcHkK9jwBpCxCqm0OiMf5LcZ/Bc=;
 b=nwvkiQRiUrhhbZeqqxLCn7qnBggG8syFaxKSOciw6P/pcBnv67xYoDJEMYFjjcDpbz9a1PNJm7967uE9oA00qQ1Kko3wwC1AIHO4Atztyqv8Al9kEPVvppcBNOfU7maXC707tDVNtw5BJmow2fRF+RtrtYift23HbjOVhgKL8Uw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Mon, 31 Aug
 2020 12:03:38 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 12:03:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/12] btrfs: Make inode_tree_del take btrfs_inode
Thread-Topic: [PATCH 01/12] btrfs: Make inode_tree_del take btrfs_inode
Thread-Index: AQHWf416xtaQUGN+iUGf+0PLqmX6DQ==
Date:   Mon, 31 Aug 2020 12:03:38 +0000
Message-ID: <SN4PR0401MB359857F67927A72EA6252E269B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:f048:793a:58d7:f0ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8e05598-60a2-4269-fb31-08d84da5e568
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-microsoft-antispam-prvs: <SN6PR04MB3885D3AE6877D372BBA21CFD9B510@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 08KFAYHsRhSUa/Bb0Hu8zDYM9UjbNMleQIWiwUOB0COXjbyKP+S+AJBjqXBNoiQ6db2Yak2nSP5TncqZm9PlQDjfiB16hMwPNnGxtpG2/jVwsgK/eugDzD9JoEE56Kf8UPVeecEiO+nj9Mpmno5eeWdJdR4OZIpimMDg5ydfCnjXvvCJuTxXZoh7fjosUGmw8MfszT9KHJ7QlvAVrcR5kl4bawa3ZaigOVp/A1cddzzlqjzoXvtWS4kQRqX19ORIu9Us5GW7QSS7pTH9iTkaNIYOogb5HSSeJZFGInub9PRxldwtZ4g0vsbqPrmiAry5mLwTSTVqswRUUapCAVxxhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(55016002)(186003)(8936002)(66446008)(64756008)(2906002)(6506007)(71200400001)(5660300002)(66476007)(91956017)(76116006)(7696005)(66556008)(478600001)(558084003)(66946007)(9686003)(52536014)(110136005)(316002)(8676002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tcIP2l9YkqHo70ef3d+7IsmQnORmmoo+6hwdvXKxoowSY4IJ9dpQLlhcqK8AtxnkyicfLtJhWPtg2rFWUyDjZ57utAVSEL9zfokIrQlgsAg2jTZegkJQKnDvi/NisGQCKpJPW1FmcGv1lI7WEqIyIdfIzo/XMYK69hPlVZRkLMc39NH0YNFiSUM19BszFWyqNkOtl+qoEG2PQYuNQQ09we7Hlp0OHOYQ4OXRabjUkLwxXjoSpIX4oG2C7I4mVRhFfTrarvSzGY6gqCjEP1kO82yWorx+JeMJbbVGqckDTrSLFGKuOcJx1Rf+FmxWPFQId9xhXtqaUfoK6F0tU9HFwjOlzyWKYn7aLjhNRbDfWXh+Ix8qCXMrRSQ7+/se/9MR/o14YBRdq8wOmajdjlRyuK60V1uoBQ+KkGEtP66oy5ochokmhB0pV5NENc6V2dIgWfP+GZRNE8VmZL3ySD05RFctS27W7KKy3oLeZ7AJafmpI8QBGcnfXGrooD3R2qqbqKm2nMh0v3v1gdHdP+XYLi+VXnp024ypnixyGoejGvzSYnBeNVQSCz1tPz/sSjOP6dRSfA/wh7rqK88ugdlsOpEOKyu8VciG/f9MqfBlPSkenGevMSVT2Pn4vf10YDFWd7UdQmWIr7seiodcSQTWGGrVHhbsjwjQRQH6FWS+Y/sgM+hMRyP+WNpF+aY/McXlXdcSK8IG/QHFa5E4ISkQUA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e05598-60a2-4269-fb31-08d84da5e568
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 12:03:38.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiArCGH7StMdHQ8dFhqF+qTQMCY3kftJ69W2pUxZ4pWKV2EaUqACTCr/SKl+0BjTv8CXn/gnMEVHc+i+AjrWcCAp/TAzGlTn765e4Q4OYNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
Haven't looked at the other patches in the series yet, but I think it's =0A=
worth caching a struct btrfs_inode in btrfs_destroy_inode given there's 11=
=0A=
uses of btrfs_inode and 4 struct inode=0A=
