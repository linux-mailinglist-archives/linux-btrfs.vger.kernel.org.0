Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4B3B9051
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhGAKIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 06:08:54 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27041 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhGAKIy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 06:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625133984; x=1656669984;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zexor+9RxHCW/JfInt+NcdUXh8XH173mUlMZH+k4FXc=;
  b=qJ2tftOuD5kZRwZfJNqZ5yMPpXTMCiJgPH2s1YQJda//CWeZ6srstXML
   9MyFFCpCZbAU8m005Wc7mWTHheZeTiym5n8qqXZJv9tgmQj02kjBeLskl
   aeFGPVP6vdPKTx0BzjvPgyrb/Ljrnh3Czt1RNwXd7U666QqQ0DVVVwmFK
   a1AObcsBdEbSGQFniggyRpDRB4HZOWG339Il6JaDwhSw6w+JVKzbxhMiw
   9EXWXFWpjiUFlVsaTko5sQ7btpoyfcUvlKL5ZotvxDk34mSKCgljXGS2a
   2oa9cQAwmcNXEZw1O/VJ69vkeJtxBpSRYlntMtzACy/d+t96ZUHnLSAF8
   g==;
IronPort-SDR: QC+5c2GN48/VOoGAY8ry5WolcpwSd3mabefiNEDe+B9vPaqYqx+wxmuYnncyU+cSUa5eN5QGlM
 uS/CFWB3di3gduYmj0k/+uKgFxFIXqJ6f5uXfZPsq2D+K3RHV+xZToqN2KAsy0CErw/2JkZYmZ
 /AYhb/PDlj3nZ0G4GryO6Go3tX4OtH8TttsjpdadT72DmvvMnbZpGwSYdAqlwiHY7a5oEZjT7x
 +1GpR3E9a4AlNgZt43Zu7Ug7Ywc5qDqUE/L7KloQ9+2T7/82RipS40ObyNt9AUd1TyjAKVOTJU
 Ffg=
X-IronPort-AV: E=Sophos;i="5.83,313,1616428800"; 
   d="scan'208";a="174004278"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 18:06:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdrWxiSYjXO7qIgpcMS5yVsje6PeYxySyfuMQnpjWTyjRjMkvasUSWlvrEvVMntMwdsdEjGgekv+jjBh37zb+Ee/Z4SZpG7bJssjgNn8x20KEqI7AeoaPDNP/gKWM+fl+PRp5lSdc7yTmEyS0k+yI9HZeSsQjM8cKwsnFew5bwiKuHLdmiy3URUeI/nR+k+ZR6IRpm0frq0iodn6P+Lv+HSzQ3pzXAeAeXWSAy3GoHgqu6Bf3sLiNHECxO3p01R0XBVcz0Zl/7sbXDb2cObt5fKpm5tIWWPUNWI7JflnTwY4ErIupLnO6ONs7675grMDr9QG5gAbBPmvl9Psa33sOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2roFEWuS0RteVGdpV0Q4PsyVspXUhvNPkZYBqOlfqg8=;
 b=gv0lgTI3tVIVeAbLV7PRwK1ZhtyaE8Kk4V/099A8A1DWRkQJJqUPKcbcq+bTnrFIgt0EDde8BJVNtMUCOA0n99+zk9tgFwulavFgPBa//2iH39Kq31vv6+Al3gNC68ojOW19tErCjQHVkvoa+saKN93eKj6G0PzH2UJP7b/gvVP8gBPfe09UeZoNeTMVC8p+Q1gD1gV9qkmfw7JCqKN1w3kvCY3G2UJccdgLRPrQvrnsURa5/zVQjdnD3C5UnRq2jqN8WaAFeY2LmLerc892824QNBdzHoqnNf8xjo//rYHYvdaC9m0HS2s3n+Uxf6ffQASOOAI7MVYQ2SkS9WrlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2roFEWuS0RteVGdpV0Q4PsyVspXUhvNPkZYBqOlfqg8=;
 b=QJ4ptKKZBVB2YIewPz88Ote9ue6nZv/NEb8uU9utMkjH6TiaIcspiNSsLOv/XVapwRN/95TrvJW44EEWTzvTFd8jSloOSSXYD83zhayI0D+Jvpo/+8aJVvMTJQCMxEbTshMVPQXe20Xx1O6cVe5KjimC4jFeKxnK563/K5XZCqA=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4921.namprd04.prod.outlook.com (2603:10b6:5:19::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Thu, 1 Jul
 2021 10:06:22 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%6]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 10:06:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Topic: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Index: AQHXbEyVniOnzHHUDkSSJPCwKxGUAQ==
Date:   Thu, 1 Jul 2021 10:06:22 +0000
Message-ID: <DM6PR04MB7081B6FD97AD001BCF85BBD5E7009@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
 <20210630184851.GR2610@twin.jikos.cz>
 <PH0PR04MB7416EADB226778E4CA09C8309B009@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f1c6:7d03:7c7b:49e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7067b954-102f-4217-4c00-08d93c77e0e0
x-ms-traffictypediagnostic: DM6PR04MB4921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4921AF8513CB28FAD1201766E7009@DM6PR04MB4921.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9WvQLnTCzt3dKlKgr6N9KHTtFRxkjkqvXT3MnhbLOvdMRzANBiVS/zk03PpAf7cKvi+na2hwsU8rP/J1gcuBdPQm8QnB99pMAMfe5TzMM7DZF1m//vk6xt8JSaKmzyWx70EQ53OBVqPsAOBB+/Wyhj3ETvhrOlIYSOZBsMhLBQewpmQTbvZYwWhs8lIM8Zu8zq14H5fVYhmcTtNFfckoeMNdMaVNoRiFEzqdyzs4p+biZze8cqVWrBR4huqiEpCgw6KadLvkZjJZfWSL3akjaPl2N0XGylNWjFwQ887uYjXHjzhbB3xdsQe5bswHbeb+jew/wf3KI4hHcCG1AbmU0255R22t+NRcLc8T7vIKTgpkaOl+P3K3NTU0GZ4H6bTj9u3nDPBwQxQs2F29pzZ/tQhjgRBsw60vhlyrLLhplNOvgI/HCsqkF6fV55yuEi/sNVBI50D8A1NbLochINDlofYTMmx0Oo39BcqjRohlnH0lUSHiOjRKQQaVU108fLuDCvuNZjzhlDmmuX7qeMQVQ8WOE4qb59lJ1Eknz6As8kgrfb/VB6Wi/SeW8yuIexkpUh+dRxC5bKZO/9zi/FrzXfXckEtY4HHJwj3heD5Tm4T5d2MgZXtTaHseGDk/NiKrfR7vIsntBqCJUCoCwtGig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(71200400001)(8676002)(110136005)(5660300002)(478600001)(83380400001)(86362001)(122000001)(64756008)(8936002)(55016002)(66476007)(9686003)(66446008)(66556008)(66946007)(53546011)(33656002)(6506007)(76116006)(7696005)(38100700002)(316002)(2906002)(91956017)(54906003)(52536014)(4326008)(186003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7tmuQelw5Wd9Lk2u1XGuXvT4+NPyLE4NzrPpjVhcneplL5t4jEGI+bGpGa2v?=
 =?us-ascii?Q?AIdZAJct8/vJE8vIbq7ex1zkDEiuymDyQWr4nH/s/dpz8iExWM7I2Vwu2SgO?=
 =?us-ascii?Q?C8F4ZIfIG1KSms38BjZgIzVG1Da2CVC57O+ObrMAFn3UsvrgCGl0VaNSzUpD?=
 =?us-ascii?Q?lOSgZqGwd0UY6cuMN5EWYliWgtpdAZECfab5UrGzrXbzciyfFTJtiLvJF59i?=
 =?us-ascii?Q?O7GGaDiKKhFnNzxRoCP9bgTH2XOzAY04OIMIFiC9lCLqthKfsENJtazPDO7y?=
 =?us-ascii?Q?f+X7gHwpgY+iOKm5OUatpoxNwk5MhFV6BbJ/uR7B9TXXkF1GxoKdazhU17tl?=
 =?us-ascii?Q?l3RV/sMUk764wLKjQGr82LpyKLejBKHrugmINg18GP6je86oK/LXOZiRSfMb?=
 =?us-ascii?Q?EddIcKk553VFOmBQOtLvNNIKNa9ZCFht//2OWKah6hN2dGXW3Zdn/GJNbMuS?=
 =?us-ascii?Q?3dJqpI5SujWVQB76DtdX3JevBNrevcR49wfMELeCt321Gw7uDqe89VkHpREw?=
 =?us-ascii?Q?qf0tNuKVEEyWtD7RfOO3DwELD7cJEJnxEpKqdXC3Hpx52H5k46SArkZNUEOP?=
 =?us-ascii?Q?qzlVA+3X1/sSxObe0rwfp3St5FwvPVH8eLTy7Z8HXDgniSZV7eCxQs1jiEX8?=
 =?us-ascii?Q?/K9sWPUO4pP2jSmjivSd5xVRiRKCl81e7s6gt0GfbyORTtQgZ0WeMlb5UZ94?=
 =?us-ascii?Q?VpHxgaOwUseFL7q+oi/PIbog5qHQh+cPAhDuDGmSEepH2bTYh4sOVn18tQ4f?=
 =?us-ascii?Q?DcZLnWD6dfTTNWUTA9xyLVnLfnJJB0QaziXWaDzHvWtEs5MFOUquyEioYgHC?=
 =?us-ascii?Q?giUhBQG1MXFpwU6iuZqjvCsGYPOhwjFSUpstjijRpbKe88o46zYfFYNXD4oz?=
 =?us-ascii?Q?Z/LziEauACOe35+hxF32TqkY1it/0emc0+0w0OxWhmj8JssDIHbbMqJDjPmx?=
 =?us-ascii?Q?ijNDg/kHAZwsGKAEFx2QivJB5NsloRBlsQSKZNJI9QhF54emmwrj8g/PmVbn?=
 =?us-ascii?Q?2kEEfto1ZfYZtTlxft5sAgbfKPXiL2XHTjB6RepQeq8iSo7QA3NcOiZmcKB+?=
 =?us-ascii?Q?x+sKt7a86Car5bzN89gMZ0JJAT/pSL5S3u6r1XabGxWfQ6ns6RZKsl5g+ckY?=
 =?us-ascii?Q?RbATm1l4uYMs1MjQ9I7Ss3xaG9Z383Dl0nvDgqc5LZK+UG6K8cVEXHSfIsvK?=
 =?us-ascii?Q?I+RF5SSi16ja7NscdcjuqimVV03FR+PuFU/A3V03fC2W3p36b56M79q9AQiO?=
 =?us-ascii?Q?L4AcMnFRBAZLenDL60lZlPaRbvBoF26TYkGXCtHFzzvljt7pPCUbIqdcol83?=
 =?us-ascii?Q?vCiIM5/+DHfVJSzrgGXoOZVhQCJdUY3zZExh4vnSRxCbeI69qZ3mCYJDuNhP?=
 =?us-ascii?Q?egeZAGDmAYLLmHKYIbh1QitzjhjZMZysS9J17Jyrdztfd67IPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7067b954-102f-4217-4c00-08d93c77e0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 10:06:22.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnY2NqqYJWYp1ntSgnbVGm6k0IkHlA7GXtHZEDSOc2dy7yLTqvzgiztCaVTux8hdFZIVj9PEQ+srOr+LxhUmFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4921
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/07/01 17:02, Johannes Thumshirn wrote:=0A=
> On 30/06/2021 20:51, David Sterba wrote:=0A=
>> On Tue, Jun 29, 2021 at 03:36:45AM +0900, Johannes Thumshirn wrote:=0A=
>>> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.=0A=
>>>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>> ---=0A=
>>> Changes to v1:=0A=
>>> - also remove the local max_zone_append_size variable in=0A=
>>>   btrfs_check_zoned_mode() (Anand)=0A=
>>=0A=
>> And what about btrfs_zoned_device_info::max_zone_append_size, should it=
=0A=
>> also be removed? In case you don't have plans with it I'll remove it, no=
=0A=
>> need to resend, it's just a few more lines but want to know if it's=0A=
>> accidental or intentional.=0A=
>>=0A=
> =0A=
> I /think/ this one can stay until we work on multi-device/RAID support.=
=0A=
=0A=
We are nowhere near close to this for now, so I am all for removing it.=0A=
=0A=
> We could though also remove it and bring it back in case we need it again=
.=0A=
> =0A=
> @Naohiro what's your take on that?=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
