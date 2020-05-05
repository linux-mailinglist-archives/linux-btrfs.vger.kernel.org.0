Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8C1C5196
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEEJL3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 05:11:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12159 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEEJL2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 05:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588669888; x=1620205888;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6Lk3ypvTxTv7+ivlnEjKjseLEtkcEK/MDUAoSZslokg=;
  b=MwDcmXfxWOj9AtAH1RJd41jCNAoxvuqEzLJn01664OW6f5ysvivznmf5
   TeI492InujVbbmBI+09Hesqn75gODFyNWjsVKUwyab/DwMfInEAwAyvRP
   qUqkUszNmri71XWIlFFvg/93QeYytNhFITnGek1VJJthg5A4KYcqcG6qG
   l+uiQs0CLZCt2E4u/fbIt/ZTL4r0BXJmYRxcpVlH6f2ZvbtEDYqpDspOU
   z1OZ5wZZCKXx5WF042TtdnhPawF4KsAUgJXmZLF0P6d7z+aQBYD7BdNNw
   V/92aI3nK94wYGIdsnL8+PeJ78Z8DMmXiA3/kvpexASMv+jjIkNuCtdoV
   A==;
IronPort-SDR: soLYwzuS3Zl95VvUE9dJXZ596OYQoi63ISFC4ulhC76qsCHm1RNYnnCXQ5KNti5VaKXo4fl78M
 ZfX3E0Ndgy2s/W2d0wEPs80aQIfkeXWjbYq4ezlFAmHOdWtgCadMTA11e1o+ok/BhSIMnxnWAu
 QLulR01KvZLfceVwh1JDSZlPMcP2+JUDRa7yvknq67nXb+iOPNhzppmkV4H8TD0G249w9hxAh1
 lLoH9c5dFA9sGue9YdKFth3QbS8QrOD15ZY/zvllntnU15ekTwPBs6E4qO4SsoI+Re1VI2acg0
 MH0=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="138371238"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 17:11:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/al85rNRyy1pjw0vB2C/nPrD20JDeN56mqTgwRj2c5Tl4LqCdnfUyNK75T0+wVlb4GCLSiCci1ox2J+4Thk0mqv6hTQD2ht9cEbkevCMtYbyEN+XHV7QQM+4kkr9oYXffMZ9klHH0GAA/4Pg8bxuIOYoQyNTRV++zWAbPoSjxPRDPgyK1dtaAXyZutUQmYKAJMS1dCW62B/uDaKzyqHObqxG56mzHdRGL/3BsHugKcp4rxc/I+EkHnR9JSBgprM6nch+w6PlbzQjaZNBB53LkyTM4mK4hsWiUe7OEY3G3n/jTCwKp7iY6QXhEzFCyGaOeWnHGFr3i92qAZyG1NcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lk3ypvTxTv7+ivlnEjKjseLEtkcEK/MDUAoSZslokg=;
 b=Dfdcz93bf5Fns947hBAWw8LrY57M4guo1fe9HD7F0ffOxLfZ01U641KxVaaHqvb9bzA1pqZ5uIctnOjVlan6ykGK6IMLblcDnXbmP3YqYl5AVBMg2eLsT1qNzJoU0Lnk+TKf76x12ITQZZmbNyvpYcPVdWZ8Zxq2Sna+vq042UBzEbDs7T3eewoc4sAM80mEBM55SmQshwtvXUaHmWl8ybU5iHH+tCbF3h9rbb7R0iI3K1ccHJq1FJO1IENWya7jnEZeoH290gtxbgdpDCIsjqsR6q25eKc4CMHsaY7ZXqAWfW1ErtK1YqtDPK/IPTSoUiOq6Jt7hyF7JkTzXUuIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lk3ypvTxTv7+ivlnEjKjseLEtkcEK/MDUAoSZslokg=;
 b=uHu19DAbje/QJrLL1qwnu7GmdJSOE/OpSNORtaXKM0gyW8NCNTfouFOij3fVN/r6LZy28M59N3XZP35+4MuRzlHYO7MbI8avMxqx2XWZ+0GxTFUktCKIFBtRNPnvcEn1ZWyzz4Iyt09j3oxizZewMp4d/y9ahX2BIGw7Iu8emOc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Tue, 5 May
 2020 09:11:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 09:11:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] btrfs: block-group: Rename write_one_cahce_group()
Thread-Topic: [PATCH v4 5/7] btrfs: block-group: Rename
 write_one_cahce_group()
Thread-Index: AQHWIm/ziLeF/85vLUaVux64UGn+OA==
Date:   Tue, 5 May 2020 09:11:26 +0000
Message-ID: <SN4PR0401MB35983D96B103B9734C0EBAB89BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200504235825.4199-1-wqu@suse.com>
 <20200504235825.4199-6-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a0346f4-9608-4559-886d-08d7f0d44a3f
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB36778C3615A1AEC221E67F4E9BA70@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlS3ixYaVOS/dgw76djvAX95nDyjdCMDoFIeNJdnx/X9J/mRG9oUhsMllojere1R6b88+c2oKroTCL0TKWapkHhysWg96N5Wx1q8QduNVkVovesh7Ku07DDlRqynkDMX1Jr5LiEdbGiXG/AZPcj3kDi1kAYl5a3NlDjXjSjDPnLKLACEAlNwiijXUNqiyb3T7hbuLwJw3DL3unimiKZMKLmFEJ+x3WGCsg8d/5LYQvP4ybo8z77dMv+tct4X9qndlF6Uylk9wPaqoWGsKu/f6zOmojJKuL6i/WQjgDopmYeN/QE5B4puJgZjRn0TKAcdK9jH7RDXNwbL8WLYtEIeA8O70DN5zmL6W5IsjTPioVrziUrofOykjJYXCQxQ1r2UdyPXBLlUi2nmdtJ3UpaM+QXbZRN60HytOiHRUAjMVhB5kwE4HxW7nxd1Uz8Cpr3rnkx6mq27zJ8t1JqpbRkjRtQUDULjOznknA/Qfsny7OKJx7xXUVDWokhzIPEaC+scyxM8JRBrNHyBS0Ony9WnBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(33430700001)(7696005)(5660300002)(6506007)(91956017)(76116006)(9686003)(52536014)(66476007)(55016002)(66446008)(66946007)(66556008)(64756008)(558084003)(186003)(26005)(71200400001)(478600001)(86362001)(8936002)(110136005)(33440700001)(8676002)(33656002)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: j5ojXOulcFYfJxfAZkJUUupD9u1LpX3qTR4/97UFu9QXj1O9jC8MjnLYyHh+mqlFJQAmAhGR0kge3VjHS1JF22VU4DM/sDNQ0ruwReGln/pfP5d+DO2TT6ORwMR3pR7pj8mAKSDozDIVNbUmm3AOko0jXUQoCgiwy9hjoljX5ZymlQ1qJPszi6UpuCcKK9DygomjgpEg+zlv/jzgBpc3eRIXaTBpfgHkgsolBLkqZH5fsh1TJMASx7a2xHTAWecrRBRFzbCi/UmPOC3hYIQ9EiTj5lgCt19UFfOo3IoZndVWAXhKpHdQh9q4DJLAZYT1gOBG4+exjdkIxrct1z43JJHJXElX+xh0tIBfvE9aPGiyM/xieIYucMhlgyOo9ZSE60g9yJXRelVdYzjXeVfOBtXWuI20vKU5Yapnit2HfelqtKc2Zbq4yx0kaCCQXNDutR7+E2USPwfDsdIaKwrZMRsSh8FtAwiZu3WlGgUU951uoGY85ySTHJSMLSV5tft9fFCTSKvsPAIjHyxSGi03LxECCUDTUR9qy8FHIPGdWRukMPGz33VfRbE53BcfqkdEJ/qXzXKBerRp0Yhkw78vXYLd+vMpTVZbzzfe8Lsn4eQb9ELsGdFkFEMzrKKmQ+RjcwchCgSaQzzmh03KZMBywvKPKwYjDzK4inCmeHTqh+xv0uQjPdAf31VUyEDz20NCbCL/rOPOTRbzS8hnog6HowleMgqZJPzVpDwNdMPDHoNcWl/NpN2HidlmHc11PkTk451ETOvk2H0YQMaxCCnMhWN3cGtORKreBBarIt3HqsY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0346f4-9608-4559-886d-08d7f0d44a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 09:11:26.4036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH9dgYJlDleAzBp/IuoRBSS7HKRVKAMiOdyCIBOgDs3d0DZYc2+zy9ChrxSKGDLGoAJ4xUFNEXUeBvhaUpM0pUAssC8vY8NXzYylhYQVZyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good on its own as well,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
Btw, you have a type in the Subject line s/cahce/cache/=0A=
