Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE3F2759D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 16:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIWOZc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 10:25:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8612 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIWOZc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 10:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600871132; x=1632407132;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hbeGSzixm6exwp1qYtk5NTW2rjLlfa44BHiVozcxf0M=;
  b=q7wsM/yNmEawxcpnfXsOLc5FWbyK1kKUbYLyYJgJi/c+2MSXmXAbmYKv
   w3hRFrmLqAlrbgSxcC7qYgIOze3VmG8VDAQPKADwIl3i2A0ZshJf4id6W
   x/Ao0Tno7Jdz1UGNki+e+g+XOKCaQAKjwtilhJ+WFPoDbFgZq+6R3A8ae
   opq9D9tO45JfGJBMXQkQq+s3CjOWwXOiswwTl3R+26GlfXnhdzZU133gD
   0xWF5xeQwAKtpvSxxvXewwYLSR3KwT2ovlaKNv0ClRgEHBceihEcasipg
   8vGP5brwfSRGAez1PPYVhYhZVg82Vsg3CVO3My8ge6FGJ2ZYJ0C73pAQS
   A==;
IronPort-SDR: jqFkIEvB3XiMCULBO9xpsrw8JuYtLufUBWwpH/jf/ripkO3hng2J/Wh/MslLjG7bSuUCf9uidR
 9l0Ag6Ive6Ajm4Bt0yyVilb75k2kcfY8IijQBorr62LE9gx8rawnyZhYiSBENsPFv4ER0BvonA
 7scToqkr9A5586HoE9883N1aR04Y2IEXtwcb+Hoxx25r+6qoorUpDLfa3w7eZfgXaXA/obn96V
 SYOYQ59N1X39LZfrF6rT/Akn33UpA8BLJ2ZxvrkczeETcpEK2I7N2PyUlZZjdRx9hpxtmJ3C3z
 9vg=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; 
   d="scan'208";a="148110872"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2020 22:25:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN0wWvhsARmIQOI0Y6p4YQPCMmWPruC4UHmuaslOCP0+vKx5SUwxebKZBMGecGIVlfEnGyqPcdeErCECWumt7KZFj1H2ZpyGD/x/SK6aeU4tFgItBkS00VTEKDPYDiN4tP04jPZznI6C4U6WFdutEYN/kdVEoNf1YDFsNrgIq68HA5CcyLbIisymc14jgBpu67QIpDA8bhBVNoxUmclWCHTR5ekxuyCF5vWoAPUA9L2QWaaoXaE+qsYe66B+5goRcW9nEqce2PtdG7blwZQEktAyaa5IXvXF9p3zPn0r9HKb9+lfMRxCqD8r8dITyIb5vlBBnrZHdekd0VEomuAo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73zziZaPpOVW1PqClC9SknnrRN9+ZMPj0oWqmJshh5Y=;
 b=BfoJFPVbKgCyrSKm2wQQZxZqPhnA14sjScYG2cQGwKpaLya+Hu1eJP1mle+PlWvfQOC7j2Z2/7mboDIsbv40gZRIkNe88x76JpnoEEEdRIRAAOMtgf62oyA78i/kC7vzPyyY8ImsG0EeLOOMcqgk5Kkky0s2dqOeBIKTdwaq3Wlo5r333U5F6C0302xb3EcWwn4mJo+9NAzaPcpeWZgR5KNyWgpJiRb+E7lv2IHrOj+SKxvD1n0syX5ikd67jGBZhl+eTUjKVezzdhTTnj0Q1yT5FKXPvZ5Jmn4Sah0fq5J8Abd3XX27vXOL1MFGAV8Atsz3Dtrd4pFT1chXsMeHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73zziZaPpOVW1PqClC9SknnrRN9+ZMPj0oWqmJshh5Y=;
 b=MQVV9hbUk9Kn0MA8Pkl74O7czGaJTNHmn3ZW/jVVeNYkIYffPwJsSiWberOtWNZ/MwWInhdE8VQ+9kgS9hzMocW3eaDfHHmdu24IxhQxdefSaVw6nj05aSDcpbMHqUxLu3dQryoqUibjTw3h9Vg5XdWZCDJ3owMX29UNcyi9lrA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3806.namprd04.prod.outlook.com
 (2603:10b6:805:45::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 14:25:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Wed, 23 Sep 2020
 14:25:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "fdmanana@kernel.org" <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: send, fix some failures due to commands with
 wrong paths
Thread-Topic: [PATCH 0/2] btrfs: send, fix some failures due to commands with
 wrong paths
Thread-Index: AQHWkBkV5cI98yIg6UWv2uOwE2vxDA==
Date:   Wed, 23 Sep 2020 14:25:27 +0000
Message-ID: <SN4PR0401MB35986C9D1C5514C73B2AAFFD9B380@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1600693246.git.fdmanana@suse.com>
 <20200923124606.GM6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 716a433e-e4d7-4600-dce1-08d85fcc84a9
x-ms-traffictypediagnostic: SN6PR04MB3806:
x-microsoft-antispam-prvs: <SN6PR04MB3806A493F2B49BC5B69453079B380@SN6PR04MB3806.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwHlu6VUViJ4WIocaHagWD+8PWWAwFWx+NHnAT+c9vcUIiI4Mo9OIFRVHTa/3SV/tNVZCMz0jM+UUDsGUfm5D0VOdr26Zhzcfudl9+uaZCUHpjq7pJn/krOYlkXKQEzPWZ5SmomqLkNZ5xqLn3Uq9IP4m7VcZ1W8C0FUGxFF7HQHskWKI2i703ivS5qYG3qhrKq+rE8DzCNTq7uCTnwTsAQOJNQKaDUH8vuZPxZHHKmmyrSdWJiEnSqncrBZ9FbMV1JnlwG4rLgviqdoMw4rfKT+yycPdMkJYg2AS+svs1HcpFcLxA22DU2C2wP0MJ54Gm90HVtHJYnRNFBmuFgrBMzp57XhcR5RYhfjJEkVHy12eemIPzslG3xRUmgpfAjgZ/bY6NmFcMDiNPjz8wRGnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(316002)(66476007)(53546011)(64756008)(66556008)(71200400001)(66946007)(7696005)(4326008)(110136005)(966005)(6506007)(478600001)(8936002)(76116006)(2906002)(66446008)(91956017)(52536014)(83380400001)(186003)(5660300002)(9686003)(26005)(55016002)(8676002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gAcC7Y3T9A/mlxGmigzbW6bJ9T/utlYJE0f9m+vs1PJz1EWNP1tKNpywgC8LZQDrqynltuR1oHz76J0y77wdfZw4gEBSE0RjbwRDKHl9B9KHs08KOLet37Jn722OBy+jpza15AW6G/NDVR87cJ6ku9bISHtNRrs3Ft1RxMUwb1w06cKx/psrMl1kyZy2khFcE6kQpUxRLuXt9MjVzYuyC0P1W3nTXOPkLa+3hOhFwPwm132z+FPwkwd19hoA7swMrsE+nFsrCTAr/0ds4ubfVnLC6hk2aDyfmShicJDcRmGAnw1r82vI0Rj7IZGgQNr6adVaAD07M0q6a+WcSVbfEm0euMbIrF0/4pw30fp4gM3RjlQ3I+J8OxKWF3BVhdriobO95IbtO+Bi/DUibA0OVFEoaMcfawJ3kE3J3IZwgYjWtLt1wzpIyGT7qLH+EFlEJdCBp+bihNTzwb1wrBlBP6L2vO/3iUt5nTGq2GpK2fF64f0ijR3KGSytLVogOoUg3MYLDCb1GVE89RiCdVkyrWe2nEVD1D5dmrHk0EudHnIWUwEuAF2pBzvt4d8bJecgoeqllHfw6V07rsAjdhmIn/z8yioLPGhO5iNEHH+4NtOqHshSe75Y1hu66Y/mBOvFkdEPamcSAq5QdXNj80HCbQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716a433e-e4d7-4600-dce1-08d85fcc84a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 14:25:27.4598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfGdU/U5iMJ6H/QcShtOx2nNw5wXdRtqULDh/lKeVHzvLffyO+JDOsrDx5Acc7KKX3AEubH/BUB5bbcHuVrChi9upq0OQ1viuaauAInltU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3806
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/09/2020 14:47, David Sterba wrote:=0A=
> On Mon, Sep 21, 2020 at 02:13:28PM +0100, fdmanana@kernel.org wrote:=0A=
>> From: Filipe Manana <fdmanana@suse.com>=0A=
>>=0A=
>> Incremental send operations can often fail at the receiver due to a wron=
g=0A=
>> path in some command. This small patchset fixes a few more cases where=
=0A=
>> such problems happen. There are sporadic reports of this type of failure=
s,=0A=
>> such as [1] and [2] for example, and many similar issues were fixed in a=
=0A=
>> more distant past. Without having the full directory trees of the parent=
=0A=
>> and send snapshots, with inode numbers, it's hard to tell if this patchs=
et=0A=
>> fixes exactly those reported cases, but the cases fixed by this patchset=
=0A=
>> are all I could find in the last two weeks.=0A=
>>=0A=
>> [1] https://lore.kernel.org/linux-btrfs/57021127-01ea-6533-6de6-56c4f22c=
4a5b@gmail.com/=0A=
>> [2] https://lore.kernel.org/linux-btrfs/87a7obowwn.fsf@lausen.nl/=0A=
>>=0A=
>>=0A=
>> Filipe Manana (2):=0A=
>>   btrfs: send, orphanize first all conflicting inodes when processing=0A=
>>     references=0A=
>>   btrfs: send, recompute reference path after orphanization of a=0A=
>>     directory=0A=
> =0A=
> Thanks, added to misc-next.=0A=
> =0A=
=0A=
Respective testcases pushed to btrfs' fstests staging as well.=0A=
