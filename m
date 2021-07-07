Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD83BEA38
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhGGPEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 11:04:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35247 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhGGPEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 11:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625670110; x=1657206110;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0iHV7tYcZWIA66sJ/fzupzkd9dXSuIGMLdHYOJP2M/U=;
  b=qGyyO9zOn2o+wnJ8l99AYYcI5F0GGqfCuXkWyUkcemvOXNfGg+lHaryS
   jaJaLnNER4hL+JinZ52dHy9e9goeYwNlyNlHRO9YyEY1iYd73BvDSHyw8
   1y+7oGUo+06CsnwLq4eiOi2MzLkqzNxnn9kA/Jsbaq8snaFqRDpzoWzQ0
   mNVHEdY6Kq246Jyk1Uk4QaFmk0sAYObm4A15pzySsFim1mUav9M9DWPgN
   ikOD5YNAVCKFKyhO1Lkeo6mGV7g3TL2l6NUn2V+bOLFnVBVS1r/MNm3C3
   4jOUn07Tou39iYCNF7EXjJu7B+IgCRA2y/cQmfJICyvI6Oj92X/ONBHIV
   Q==;
IronPort-SDR: 2T7LR0JD9wJlDhVus9sxLXR4UjrgY0EK3xWEwA7IKydf4ruLHo7//s5uxYiyqJQ7vGGRCb82fM
 MnQiFpr1siW5vBS2h+6eOVvyQ8A4E+hJsCZo6LcnpE8aAHHt88vKz+YBNcdbGM9H4JqwAfoRrG
 GNfSZMW3gbdVrEo47817b1HjL1VfYL34ONIiavWr2IlgYEtYuVysPcH2bpn8J5R4agOGgcPtvK
 j+HhHL4FKZF+HMPJ5IDIbaxTW4+UcEs7hPZYzvjBnPe+IxFqUw7zUZ1+A8FCykAflAZynjxJ5G
 mEk=
X-IronPort-AV: E=Sophos;i="5.83,331,1616428800"; 
   d="scan'208";a="173944913"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2021 23:01:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdPimJmfwnMacu/o90weldTeX7CuN6jEV550JBjZ+lQR7bwzobW0e7uTidNaXtnPd6k01LqiWkXlIBocEF4UF1oNnK36cD8efiIP6BzDsiJeT5gMO32VapOAm32uds5wdDpN3mGbrHpLIhqZoZHYtpG48i8Rs2qwpQAkt10IvPbVst+pxBQjRDlQvS3aUkZK72jTPxt4iaF15RRIV6/Jws8gaDNTPXv+MDr37J5BfDUw+CI3iEhGqamV5SKXAhXsORv7oA1IM8h2XlL9MtbLrfFZ5wU6fRJpNEbQK1a6+9NeefM3nbtzVjHuxtwkOl+tPzlg8dPomSIKnddxad1C1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iHV7tYcZWIA66sJ/fzupzkd9dXSuIGMLdHYOJP2M/U=;
 b=ULDLLhPpArrwyVMQ//5shDJeqoZ2tbW20oZtsKY4MRD0+FAf5y3soVMEg8x1B2DtZhIrE3/42slPSq8GEAxodt4mKLey+spk09Mk8/7NU9C6GT4zvqmhoDfyfPElczpJjq3IEd+g6+GUnS+jq2lv6PZKawhECz5ljovzpxcl+FmWILXSx5FKLN8fEoNq9e73T2Jy7XHy+bnysOP6SUGDM93z1D1ybq0r/7sG/Kf+ns4dZ+qbfig3iZtgJNQNrZyN2OiGSFqqKX2mDlvupXlY0rGKAUEy807jQkEf6sFgskKXm2VAYib3+tEuODEkjnsYS4fjwsXRkp43qn7tBgAjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iHV7tYcZWIA66sJ/fzupzkd9dXSuIGMLdHYOJP2M/U=;
 b=bS56rKPZFXikRwYDoxEQfpbhSTzml88T37sjR4wDRw931ZkNMSJcIMOQRYbxVb3V0LhWSnG3ii4Edlmwz3MQ+rKaXA+fGH6Yyex0f1cdpQFzWIj16qYCgFcFXvQOMLjWWFSFnVHGFk5fV1bN84JzmWVv6hp/hH4dIOQbh4Y8Agg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7269.namprd04.prod.outlook.com (2603:10b6:510:1c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Wed, 7 Jul
 2021 15:01:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3%8]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 15:01:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs-progs: default to SINGLE profile on zoned devices
Thread-Topic: [PATCH] btrfs-progs: default to SINGLE profile on zoned devices
Thread-Index: AQHXc0EDcsewi6Ar9kOYVUBSRO35fw==
Date:   Wed, 7 Jul 2021 15:01:49 +0000
Message-ID: <PH0PR04MB74164EDF2921DB4141CD40579B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
 <20210707145048.GK2610@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21934216-1adf-44e5-9bc7-08d9415825e7
x-ms-traffictypediagnostic: PH0PR04MB7269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7269D349D753B518E4EC4F5C9B1A9@PH0PR04MB7269.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrqrrtJqCfWgZo3cZU8zuHljljVX2vP2DmQyUjES195kRm8wMTMPG+VP+ggKGvWFkOOn551vMa7KVmel+C+k73ftAVJtLdiqqeu5RY2eTOfl5VREZeVw+nI3apHZ8sNwHzNFLrfTO+Rzlo1iLRptDve+oxEtKJLgOFs86kncFOS3i13NuCK4B5zqn6jbtxOcVtGMmz7YnxKx5LSX+Ea41KIui72fEIjxWkaqmzxCgHUR0QbGl3Zae5J9lo2/s0Dxk9yuZ9QRC3r9yeLaMtccVtIL20z98Az09jit05PNcTDdhK0ZpddUqXncJYzthMyLrheWRLZ6vpUFPYfIEK0RqP35Pg6jXZtnZ25bSi6js2QUdOF24kaAdUId2WsXgfrXOIAOB6zYpA5jS8QcyvF5x7YItUv/BO0hWJNy1NfZS6k4ngTOhAS7Xp98K3JgiJzh2HJWJwnySIjjI4IHMCnM4p/J8zVK1fzS/QGxEXwn+bhwajRiUnd6ZpYp3kHqPWNInai8tpCAKVZ8uPmPYgh7gozDjHz17jXkWzGJWmflLqOs6rTEAtt7YgZUlnmjoxgcQqritRXJF/tnMj3IuxI5lkG7cLeTs8Urcq74iOkUbyo/84lbxRuhCXITTIu7ZZGS2kCsDULnce1meyJHV1PSfwzckTZDIl4BCSH34alKdhfZ/x/MQU6Z3Ca2F9Eo0bgEnLk1k0QcmFIVmONkb/D7q/qfFm+3vNjb0AcD5zPtg3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(186003)(478600001)(52536014)(86362001)(71200400001)(54906003)(66446008)(122000001)(55016002)(8936002)(64756008)(966005)(316002)(2906002)(38100700002)(66556008)(6506007)(83380400001)(6916009)(5660300002)(7696005)(33656002)(66476007)(8676002)(66946007)(26005)(4326008)(91956017)(53546011)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u6d4jr65I98edn5rV0llQVC02Ci/axTKvyf+uXLebfgWRQ2IJCbVJu80QrSv?=
 =?us-ascii?Q?A1cRwS9dYnmJ/DQCNPFAg0KN4HQfzBqU5trg6nxU02NrOLBsgFLoPV2c1X04?=
 =?us-ascii?Q?6tZ9oIlt00hvUHBULgF1aNDsDDyPxle2PcOsSCEdStkrplWAxeZcTBWNATc1?=
 =?us-ascii?Q?fPBmnPDHicUgYXkwi5OgrX5edmLo0gPzekPRdqHsIqDx80oXPYll3+9a83YV?=
 =?us-ascii?Q?AV5bwLoWo/mJ5HINDybGfsqAo7jZ9+APhpSmCA8T402H+DdfNEtVpBl8c6pc?=
 =?us-ascii?Q?pxVmrum36ywrCGcSU8k2llg0/W30mwYiOgJzPLbHiEyjYZvF2UVkrk7rslG4?=
 =?us-ascii?Q?y+sKhWX+hzDSUdTF1EGcR+r00jcZRYJe/UMqUzLTh+UesvbwoMBCS2pSHpVO?=
 =?us-ascii?Q?oLr+Iwg2bC10y3suFMYwKOk8wBNQlxB3gtaV33qnH1YKhGCGUE8OoxyfZZP9?=
 =?us-ascii?Q?829tAg6Zw4QiqgZJ+NWDMT+kROUDu4KwjukqbpMj0teC9708cI9m1HBP6kWK?=
 =?us-ascii?Q?R3ca4P7kMsMPDftrz+PMNYflOUh5Re5zhWxw78iHiXvkKCg3NRcTSze1Q0zs?=
 =?us-ascii?Q?OpxQnUOAJzxt7FC/RXcA1nmRTv+MpF3O5aBqlgE5if+1m01rRlC66tQuM8MY?=
 =?us-ascii?Q?OAYK3apNuJMlYRVz77KlkfN/eEmHsI5odtqwVzlDlXLqwZUTbbVImn+UWTLo?=
 =?us-ascii?Q?LCNwfO/lv1OKNWEJul6sKzscy/23Fwyp+wTmi3vo0n5QAokgoP7sN8wJARrN?=
 =?us-ascii?Q?EVOg2DSiQVLu1zZaSHGNu5bN/BI2jYx8n8b9U3KtyEWaHcGMeVI6IN6nBnbI?=
 =?us-ascii?Q?pI2fgqw5IyIdjS+ztxismALE4vK8xOw5l1Am3F8L/qwEALMbXfWxf6yTQgdc?=
 =?us-ascii?Q?UJztd92+jjefeLqAz+SgrfvdnU0aB2XCCXjwxSgoLdYbkpLdkqCM2V/CLsIu?=
 =?us-ascii?Q?3b25htruCJPVHz7jWqMpWq/z/+QYofQmV03OJPJABXVD4W3kk+kR9O+jNU3s?=
 =?us-ascii?Q?vd2MLpFbRXZYs6zQj2lnnxlkF1kI4d594lbykmkdtwFBhtSFC7I97yul3xC3?=
 =?us-ascii?Q?YfFM/POz7VuTBVLOkRrm0iZ+euS6c6viO0uHbJ4AA1FYWlA2lJhffPgE+Qve?=
 =?us-ascii?Q?OrXdacYATn46vEYc2eOh3MwB31YGu7p3duMLGaes7f6G3b4KquzmozLC3123?=
 =?us-ascii?Q?LcKzNd99OR5Fzex/fvfY8oofvvz8J9OrTrr3BLpGbuzh+ZwL94S0w/g2Um4/?=
 =?us-ascii?Q?L+JIR6m4zqGMlANze7yVAMoTd/xkJo6D+qlBIHC70r9GXhFUbGTCgJwGC/6T?=
 =?us-ascii?Q?l/JQppF+AylCXtacQqcNifVL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21934216-1adf-44e5-9bc7-08d9415825e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 15:01:49.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8GnlBtU1M0D8alJnX8MAsBChhQOcoKb1YfpIp+HNS9XiM/eheElaTrWMv0LntCieWE3VefktS3V5epFNETXmtk6xLn27S/VN0gUCpsdTZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7269
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/07/2021 16:53, David Sterba wrote:=0A=
> On Tue, Jul 06, 2021 at 06:19:22PM +0900, Johannes Thumshirn wrote:=0A=
>> On zoned devices we're currently not supporting any other block group=0A=
>> profile than the SINGLE profile, so pick it as default value otherwise a=
=0A=
>> user would have to specify it manually at mkfs time for rotational zoned=
=0A=
>> devices.=0A=
> =0A=
> Yes this is annoying but careful with setting defaults, it's hard to=0A=
> change them. And in case of zoned devices it will be possible to set=0A=
> something else in the future so defaulting to single/single needs to be=
=0A=
> justified in another way than "currently we don't support anything=0A=
> else".=0A=
> =0A=
> The SSD fallback to single is not showing as useful and there's ongoing=
=0A=
> work to make it default to dup for metadata again. For consistency I'd=0A=
> rather have simple logic for selecting defaults and give hints=0A=
> eventually instead of checking random things in the system and then=0A=
> selectin on behalf of the user. Unfortunatelly it's not that easy as=0A=
> there are conflicting valid interests and we don't have defaults that=0A=
> fits all scenarios.=0A=
> =0A=
=0A=
Agreed, but without this patch mkfs with default parameters on a rotational=
=0A=
zoned device will fail with:=0A=
=0A=
johannes@redsun60:btrfs-progs(master)$ sudo ./mkfs.btrfs /dev/sda=0A=
btrfs-progs v5.12.1 =0A=
See http://btrfs.wiki.kernel.org for more information.=0A=
=0A=
Zoned: /dev/sda: host-managed device detected, setting zoned feature=0A=
ERROR: cannot use RAID/DUP profile in zoned mode=0A=
=0A=
So defaulting to not creating a filesystem won't work either.=0A=
=0A=
We could improve the error message hinting the user to specify =0A=
"-m single -d single" on mkfs but that feels more hacky than setting =0A=
the defaults to something working.=0A=
