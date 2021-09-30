Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA841D6DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 11:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349617AbhI3J5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 05:57:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39941 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbhI3J5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 05:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632995756; x=1664531756;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vgMX431kESF1Xs4sXi3qYmn5Eo+1adcnLaQmbL6Fu9s=;
  b=e05Yjva3prE+BwDoWxw+PvHBo2Uu98RWHxgHXZKiQ70LLGery//65Id9
   DzxLWpugAXzCvuPTY4aJKkejzq1DAQvnoK84UEVFLC6plr0EBeKzC5Gy1
   9ma3hkM1H6oGc0yFJoyPE4lwX1CzOwcJXHGkCQJ3iQBus68pL4VPJA6FA
   oxsaSOwzkH/pd8tw0yLbEsGsl76wYSvQbgsgwZbOEa1WQVMUdW9pbCyq7
   rdLbF0Lm9+hObnImcThMXuruBG30KDCYcDZLscU5JzhYqoriGfUitXUE6
   4mlvLVAfgXeQQwMIP8F8o44lZxl9HW6MRMclfjBha24R6q/7woSNZ6zs+
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,335,1624291200"; 
   d="scan'208";a="186202175"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2021 17:55:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfDaeI4ZE0C4abNfdp49UhsZKELD62KrMWUI4Rzl5lQzF9rcoHqnnu0qXYz1ok+tcVZ7Lgpz0b7AhlMxfKuFxWS1xZyS77DMPchuHJIdab/FAGlfPBvRB6XzEjf3eN/7rX5u5VydBsLcdshRRevtsDViMAJq8InM6ePxktH0V4w32cEpmyMYhR31wCvvhEJO6qxKiD5Sy3r9xreokHqCrvMXuTHpGPsEwAMM08qMLGb4/YYHXplEehhF+ga9i9aN2E26t4BjO1BPb1PKIlC7AEo6MGgfhzNXDVjhKXqsN2UWcgAo/TJ5Q6eUNgaVtHlKhzZ7YjYpromyQpOSkcJSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7rzXZesHuaf89WWKG83/m43aoVbVbq77UQ1Nq4ap8JQ=;
 b=SfXvlNgx5iXRQ7VB8JBap4NrWHcqOm3g5bWdvgNxFprnpKAGNuic+SpJhQtD2b08L6BfCJ8xwrjQswmIaid8KOufdfkrKBYy+QDle5gyw2dihGLpcuR0moREsZwwWj9xWbnZjs3Qqy2e7Fel5pHcflW+TI/rN2oOrebCNGfh707d7Y+WT1BSmbcIEtyYNMISmeM8UnMffKBNC6Xk5XNB+pemeixu+5L/9zS0kttNYTy3JgPmbylVodIXrHaluvhyhnVpGzWQbuk8CTSHsfwpekXSA5im12hsLqP3uh5+27De69tRd/9ulR8Ps9yWupBK8OBlgOPedlN+iJ8LjELufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rzXZesHuaf89WWKG83/m43aoVbVbq77UQ1Nq4ap8JQ=;
 b=g/jSI3oT6raJTE3iyasHWDAQehoNJFJ2wqzq3fJRvMT6LklWsABqXT0gK1ZUsw1YQLeTftOMErkIaJ91+05JDZS50/V5yga6XowvK6qdLjSbfEEf0ZaL4+NaKj2EUSsJ+Di5g27Mt5ixISa00RcFiqSgTHFg4pEJRMYVy29mzI0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7240.namprd04.prod.outlook.com (2603:10b6:510:17::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 30 Sep
 2021 09:55:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 09:55:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sven Oehme <oehmes@gmail.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Host managed SMR drive issue
Thread-Topic: Host managed SMR drive issue
Thread-Index: AQHXsXGwJGr/oBwu5kOQfX1ME0hbsA==
Date:   Thu, 30 Sep 2021 09:55:55 +0000
Message-ID: <PH0PR04MB74162F06A2AD5D8379F2682C9BAA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com>
 <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
 <CALssuR2K8Dtr+bGSYVOQXcWomMx0VnLwUiB1ah44ngrJ5trnSw@mail.gmail.com>
 <a9764186-90ab-6ff3-7953-07f39d69ea5f@opensource.wdc.com>
 <CALssuR3A4Um8raXi1W7O74PbgbcNmummasfZrY=sPj5t6f+eWg@mail.gmail.com>
 <b010054f-ba99-6cf9-8318-267e3b4cff90@opensource.wdc.com>
 <CALssuR1sqLDkyf4iyFhJv108BePHSoMPD=r+pDfeb=mcPWNaVA@mail.gmail.com>
 <7038f4b9-a321-ef7d-1762-c0c77d666d55@opensource.wdc.com>
 <CALssuR1Fpz=wXsCY6N+6ApU-1_tBzjj_==+3s2NOws9fPReYDw@mail.gmail.com>
 <CALssuR0D9r5_rXWsL1Qt4ouFdUQdrYY_VL2KMaNJ442bqHREsQ@mail.gmail.com>
 <20210928071002.jzm7e6ndm2qh6x4o@naota-xeon>
 <CALssuR3SQPev0f2GYo0s-w3pk-jP-GGPZiX2vx9597NQBW8gUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5688aca7-3587-40f9-ee4d-08d983f87ef1
x-ms-traffictypediagnostic: PH0PR04MB7240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB724021B65B1B46139F9204D19BAA9@PH0PR04MB7240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPc+/zOaFzyfTLnf3O3rgt9GaGikTC7q5Kq6zF41hq5IQCdxXBI63bP5t3ZeLBnwECFNjdUvI5d1nT5rvehRDRflMw641+m2tiBmdfHfzdUbPMNRhyiNNa8QMea2yL5nub0tqxHXDLSI8zTFdX/XFusSj0C6eaPsDot5yJpZhISAp9K5NFYnjAP2ume5oDHKhOUCZ3I4x6vI4euV409prt++9NhUa5q05Gvww5M7sFfeyhVGdZQwybatJ28cY1APeTcaPOYoBrm3m8fwSgwD6laTBY5TWdIXK5FnCl0JmVGUmghEORNE4nuQ56OzhgUki69CbIrhYyP87gO7fBii17qREc8m9OAwf1q0Yl1287juHXzl5QABWBWvajHToYrQGZ6W/kLhq6l9U4w1Bp097eB2tXCzPa0P85XmbtVOY4PxcbULJVIgU/yrcQCVP+7vybyJ5hXuOi0ns8fcxEPlwR4MqCsPOup+HTH5bBSeD33xEHDtWmFQKU9qrO98k1Lf8lPzRwqyyWDcT9XaRt+cJuLPsC0zZHjeO9VAez6dhg/OGOltlaw+l9NH5i/DndMuPbBcWulLL75fhNAldb3391dAUXboB7LhR6imy8+rlr4bnDjnss3178SVcY+Rj6zAapn94ZrSfKmP4+BvDVvDSz6rK4k8NEFR+2ThIzbZ6flkxcvonolDZjTDSdWNsZGnhVbVtAj+CxHJNIBt+L07Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(9686003)(110136005)(122000001)(71200400001)(38100700002)(2906002)(8676002)(83380400001)(8936002)(7696005)(54906003)(316002)(53546011)(6506007)(186003)(86362001)(508600001)(33656002)(4326008)(5660300002)(6636002)(38070700005)(66446008)(76116006)(91956017)(64756008)(66556008)(66476007)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XxkOkigLGz0vR+J/61G06nuLpWj69nQcAsB95qWi9UnIXcxw4WDcrVHcj4MA?=
 =?us-ascii?Q?Fc5Ne/QfOfrA9qb3HQB9H7uRUbY251BfD8Os6iLNb07/ZukgeEujtp9Mpkm5?=
 =?us-ascii?Q?SPNvtCf9oN0oa8tWoWvvh9mhPV+ziN61V/1CtVwEh1/Cg9dO+dJhIwViQy9W?=
 =?us-ascii?Q?jKTV6twP40tzP7C7zdQzGlxnmvMWsazxeKdGauyeDi7SxrGohUYdlxlHWxu0?=
 =?us-ascii?Q?jbThlHSzxBw+RJvfhgTa9ePKxz5GbyifS1QaIdd+XbMxW4DK+I303DTxsL0L?=
 =?us-ascii?Q?V3jG9wBZJFRwH+ZTmtI6URXSnQMz7iFSU/FAxVhC5E76XGekWx5/3D2mROjv?=
 =?us-ascii?Q?WAs2VV8D8eOnlcotbd+SFg3KLLmbeVoX7pi5Vm1maHxArOlcPRZP5Wnj9IL8?=
 =?us-ascii?Q?1VAwpa+avvLXs5rRbOQKO+KC8BibYDzotDgaa2/WTRgz0SuDxnbRMet9/hXH?=
 =?us-ascii?Q?PJap23CsEUKMq4/B456Ve89RP6NJxu2ZQi/D72mHXzsIDKMSY5pGgs1Fs3EE?=
 =?us-ascii?Q?iEHhUYblbAUo4ViHYmSPwfcAArycnBx5PcNbTgdEepXNBii7FXcTKeL+12Hp?=
 =?us-ascii?Q?bjebcxfwNkfpsrRYixSyz1y5jVRUoM1smFXmvUhHvpu/BeQI2v6A3UWQKC+t?=
 =?us-ascii?Q?87v92cOGFHidk9bCumatdHf64cptWHdGQZ0hc7vgKWzHVlyGtQyfd8JucRoa?=
 =?us-ascii?Q?znVNDoDuuOGc06adSHPoE3XWH53SZ3yFnOTA4qNJjwfTbXWCSFsm00wY2bqZ?=
 =?us-ascii?Q?oP4Z43Ua6fzLaB4VJmM5ZlI8sODiwEeYWH3vc00kuJ5gBet9bDD49R9M2ARH?=
 =?us-ascii?Q?si1NiFue3L2B/w8dj8O1Y5SXuSGLF1Gu401XugI0BVjcNpl2hfcJvMGuKoBV?=
 =?us-ascii?Q?ureQFK9C041QHTmLUwU8k3VmdSkjIUVhqdG7ZialMd9DBeb0w2zFa+xppWcu?=
 =?us-ascii?Q?U0syGM6ICYgSUHxElTMEWsEDmJFJUoF47US7Q28YHG3Ttj1IIAMMy+kWNQSq?=
 =?us-ascii?Q?EPIgNpN8Os6wVc3GLOx+MuLhobdEI9frxH/udlVTG08bU4LeDRkeINQL9PAw?=
 =?us-ascii?Q?6DzRwf82J9hlgMOqJGZsrSZB3ik05F+Of/8BukxA9ps5CkRq6UtBNOdJkLxD?=
 =?us-ascii?Q?mgdZnV7DD6Nc7J9hFT+Rue0OdM0VRY6rMy6XE1iPM3EM2FF3z88AJEfXsNTU?=
 =?us-ascii?Q?9CMmkOP/QGA/so0FTju7NaG9lJZcBvm+Ob/VeAnT2Lvk+Nq9y+FhW08GapuB?=
 =?us-ascii?Q?gd9l+HsA0bBZFhUbIT37+a1G8F4IJI+tBhpZ6i0FM5KXSTklBSMSxG8kDMKq?=
 =?us-ascii?Q?RtSWyftz8WuyTGAWtXYnkL6Eg03EO6NaCkS4vauAQWxQt4vUOXPpmA/Hwc+m?=
 =?us-ascii?Q?JBIxwYhNjqOOsrExxTKlR+iJn8/IP7LTJ9gaulFFv52JcEFuRw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5688aca7-3587-40f9-ee4d-08d983f87ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 09:55:55.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+/JeOjjQktsGEOL0bFlzMoMVV3CCBgu9OF7aS5HzFWot7Uoap+nnSo9IbrZznDq5j8wTkZ/tSOAPK1ZUY/AJNML+hG8XLMFaT9zbmjRK0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7240
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2021 13:49, Sven Oehme wrote:=0A=
> the host should have plenty of memory, it still hangs right now and=0A=
> here is what free reports :=0A=
> =0A=
> root@01:~$ free -m=0A=
>               total        used        free      shared  buff/cache   ava=
ilable=0A=
> Mem:         257790       12557       30211       76367      215021      =
166105=0A=
> Swap:         40959         452       40507=0A=
=0A=
OK Naohiro has managed to reproduce your problem and while we where=0A=
dinning we found that a) the scheduler tags are exhausted, b) the SCSI=0A=
Zone Append emulation has (two) invalid entries in it's write pointer=0A=
offset cache and c) we have seen blocked instances of ata_id.=0A=
=0A=
Maybe (just maybe) ata_id is doing an ioctl on the drive which goes =0A=
down the route:=0A=
sd_open()=0A=
`-> sd_revalidate_disk()=0A=
    `-> sd_zbc_revalidate_disk()=0A=
        `-> sd_zbc_revalidate_zones()=0A=
            `-> blk_revalidate_disk_zones()=0A=
                `-> sd_zbc_revalidate_zones_cb()=0A=
=0A=
and IO is ongoing or doing completions. Both are accessing=0A=
struct scsi_disk::zones_wp_offset, but sd_zbc_revalidate_zones_cb()=0A=
is doing so without holding the struct scsi_disk::zones_wp_offset_lock.=0A=
=0A=
This will then corrupt the zones_wp_offset array.=0A=
=0A=
Can you try if the following patch makes any difference for you?=0A=
=0A=
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
index ed06798983f8..e04f55dde70b 100644=0A=
--- a/drivers/scsi/sd_zbc.c=0A=
+++ b/drivers/scsi/sd_zbc.c=0A=
@@ -694,8 +694,11 @@ void sd_zbc_release_disk(struct scsi_disk *sdkp)=0A=
 static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)=0A=
 {=0A=
        struct scsi_disk *sdkp =3D scsi_disk(disk);=0A=
+       unsigned long flags;=0A=
 =0A=
+       spin_lock_irqsave(&sdkp->zones_wp_offset_lock, flags);=0A=
        swap(sdkp->zones_wp_offset, sdkp->rev_wp_offset);=0A=
+       spin_unlock_irqrestore(&sdkp->zones_wp_offset_lock, flags);=0A=
 }=0A=
 =0A=
 int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)=0A=
