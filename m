Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C793B273C07
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgIVHcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 03:32:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34775 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgIVHb6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 03:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600759917; x=1632295917;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OBWuNALCnfLdjKAkdjtNwd9fAkCv8SAhW9ygkTmNM2I=;
  b=J4Z9BFNTQ1iFphnvqNy1MdIPH7vca/KiyM+PKx2CPonfMu0vjz4oW7VF
   sKpQpX4lrE5S/ax4juQQDhQ7RQvnjsjNCKK+p0pvYURh8j3H6ic4fShvi
   phwQHtYTe+tGvSS+mGrx3U90B4nbad+obS5DT4eWq9/NnBXgAchtFJfYu
   rW5akxgUX42hq2G6Uvlhu3659pobFTMUZCa+i7U0T5rhQmna1xIfPh1bJ
   XavGGHoxaub/SQI72YLnQfDLO6FadGLyB3cFh9u3pHJwg/W8pU5jA9o6b
   inZhGdnzTzEdqbaJFikZ5Y7HDXu5BJh0eNO8k622K4npF+lALa4dhIPmV
   w==;
IronPort-SDR: /+dI3skuV2VnxtHC3y3TzIWhpXOtjXkO38mnRZudwuHX1T7ZFoNNBsNCUIlgRdt1+WGyFonK6f
 QosvedBHrz3LoE59ujd0iDt6EwFeUTA9Y5gUEEv+dOtCia4s/qNxwo+tfgzIY7VfTm4+bYESLH
 jTyBRBLwZ0vrY77dvDhzySiVLKXtBGTBRJrXh4chY8Qs+xChI0KeXAwVdWl1eSbOXQshim+Xeu
 rPqNngQ/sTTVKCe6rKBjy/czUWh2R1WpITU8ZBPaeda/guh1MvUA0MhsbciNbCgf7lNWBF74u0
 m8I=
X-IronPort-AV: E=Sophos;i="5.77,289,1596470400"; 
   d="scan'208";a="257668716"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2020 15:31:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVW1fQxwvhg145pCC2+JZmfRIxI6Zadk5Cgr47of09qlfGbg5WdDHjK38fHUy7g9+3Sm86fNBgyaK/p8+VT/zIOYBuLeyL+Pkeq5cirqR6C2YrRtBBZ7FA9c8y3HxspXMmKwlRMY7xezRW8rt/RfPUreLapuQCJj6ZFujmHJtWw8P3rceQ9jTyqLf436L3Nze7Z847hz49OSn9SGII7IqSaERU5zZhQNgv2elHvgOOk0eRFVsstzRgrDDZyHUY6G6RlLxhucXNbVsTZ85djjaExe3AHFIxYoRF18VJELTXFIH0mUlFDz/5jrzZ4Hz29Vxtt5D5pFMuuB7JZPDvxP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBWuNALCnfLdjKAkdjtNwd9fAkCv8SAhW9ygkTmNM2I=;
 b=m1KscqflSHghR0MmQW17qNQgOYpZWGYSdrnJcFj4hZxRTm+qL5/LPJpDf9wXDXce2PojPxOuCMbzN/tJ+w1WrxwYzgTi3S58Olokax5DcJzNkETDfGg04lVTrbaRuzvf2hWqw0lOOD2YdkZC1AnOwQOqEGGBtbDPb2tFEd0WIgweb6zj1NIVr0HLiKdrrkNRbrNOxgcRH4ujockheeeheKp/rbFJtEroQIbZD/sxl/7ZyG5w4DxqpKNywbtXedi4j9kzL1DY+Kt+po81NU1HqhqT/Dp4gfax+hSqYpIMG7mClidE9V5la/p85ngXCVPTBLDimg1cX+ppmtmXP9vbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBWuNALCnfLdjKAkdjtNwd9fAkCv8SAhW9ygkTmNM2I=;
 b=bkuxxSUBB3buPpEQOYAyy2snYhUy/86HE/vW9OlMYlgI7yTEEdBsMfrY9GRDGCA8ziSLl3bZa/GruoFia/cR+WiYBNSmpnIqQ2j7fWthHIbQ2/OGsORLuDrGOBv+WJBYfeurkUuD+y1wOyxFG0Arxh3vsDv5qkHcsH/2ifq8iKQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4781.namprd04.prod.outlook.com
 (2603:10b6:805:b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Tue, 22 Sep
 2020 07:31:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Tue, 22 Sep 2020
 07:31:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reschedule when cloning lots of extents
Thread-Topic: [PATCH] btrfs: reschedule when cloning lots of extents
Thread-Index: AQHWkD4DVh/O4LLPQkW1WjKSvaAYoQ==
Date:   Tue, 22 Sep 2020 07:31:55 +0000
Message-ID: <SN4PR0401MB3598FC44A3C81E9D3A9FF9F49B3B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <23e7f73a25cea63f33c220c1da3daf62d9ffd3e8.1600709608.git.johannes.thumshirn@wdc.com>
 <20200921182856.GP6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6930e093-f68f-4d99-7680-08d85ec99556
x-ms-traffictypediagnostic: SN6PR04MB4781:
x-microsoft-antispam-prvs: <SN6PR04MB4781CC40EFB595F299021C3C9B3B0@SN6PR04MB4781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TK4r+Up1GwFSFISbDye78bDs1JEHsWRI9NW5GQDaE7Nh+su9utFu7g1pV1+lHMDepsBf5m7zykmDCN/KDEnFwIseLyFcpiE2qyZJ2WLix1I6rVoxjGDe1sgzD2FoE8x/0hTIzr9IoOQyPJ30288aW4UrSefM8z7bJ0qbnlUv07J4Rc8SuPOX7TYPaRMHB0rTHu8F8OI2pZeSCsl6SYn/vlxdgtCzttSc09IFWVFqolpvCrrq1J3JT4VZiA3zZPlVbRZzmqLjkOyEXXKNMvR+HKPWJyctOGxIkvPCcLq3A76mIMLpsUToLle6GouNx/H5ZEbUkrMH2mQZXlpan5Vf2IcorZNVtBKzQ4HybBIOWV83/7fdETbLd40FUgwIqCocdHSH7dgw8JJnvKPnss3DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(52536014)(86362001)(76116006)(66556008)(5660300002)(4744005)(91956017)(71200400001)(64756008)(66946007)(66476007)(316002)(66446008)(2906002)(478600001)(186003)(4326008)(9686003)(53546011)(7696005)(8676002)(83380400001)(54906003)(55016002)(6506007)(33656002)(966005)(6916009)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qX/f0LMVpahS0vMKiVBeGSjYFS3PqroiGIK/+/pYjxxEKmyqcsd+MlnVQV5UMHasMlWk7JLod4uFA0HhBrMZaqwdpy5dzZgArGkz3DSX60WS7ttjtJ1gKHEgi2hlH2gPbacoTzTNvKFCIGMgx92nmHkxvoJcrthDI+Hsu1+feFBvZb2z+WWslDA/k+OB24OblEY0hfM9wxyZdXPTptEgX7ZbLiH+H7sqQJalnU9ey9BP7V8P0RfcHn/y5IckiWuphHmz5c1JGpL3BUB3JXdKFuU2pSVNalkzGlpFbOv0Tvt042cTtzfuObM3eB7aAuoz9etWiRU6KNzCxW1jjBUTWXMYK3QQocvlf/lrDOVXK49SdgBGGfz9EL13usaBdH0EuMdBWath27QTXMjR/77wblECd4RsQM9FOvQWQRENwhStywYuid138lamTyj4MQ4e710kqcz0KmB/LNv5Gh9tTMsEwAH1UwqkQ5R0Kz9FZavf574nUk0fzGsnuNBxJQP0JNkVYT5tcZtI3S6ktc3nQJLSqz9Q2yH8s62P2t6afWDWD8RjZCK9vb+VeZpv7CbaJnpQlYwQjO8YO1nw0sEFZmh7riVMknHOln3hfmnmCh6wk03hVklL3FwLJ6PFza8POWukPVu2fQhHDOBAVmBF9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6930e093-f68f-4d99-7680-08d85ec99556
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 07:31:55.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MsT+nyhp4PBPx8x/kafFs7yUFASVZyO/S0tnKRNbaPdxA2AtlxSSSSgtkPSwBIOXW3XyNRNWnDJJOUaA3JBRIsNhreAxbmLoZkLQgDwbIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4781
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2020 20:30, David Sterba wrote:=0A=
> On Tue, Sep 22, 2020 at 02:38:10AM +0900, Johannes Thumshirn wrote:=0A=
>> We have several occurrences of a soft lockup from generic/175. All of th=
ese=0A=
>> lockup reports have the call chain btrfs_clone_files() -> btrfs_clone() =
in=0A=
>> common.=0A=
>>=0A=
>> btrfs_clone_files() calls btrfs_clone() with both source and destination=
=0A=
>> extents locked and loops over the source extent to create the clones.=0A=
>>=0A=
>> Conditionally reschedule in the btrfs_clone() loop, to give some time ba=
ck=0A=
>> to other processes.=0A=
>>=0A=
>> Link: https://github.com/btrfs/fstests/issues/23=0A=
> =0A=
> It would be better to put relevant parts of the report to the changelog,=
=0A=
> the fstests issues are more like a todo list than a long-term bug=0A=
> tracking tool.=0A=
> =0A=
=0A=
OK, I'll add one of the stacktraces here and remove the link in v2.=0A=
