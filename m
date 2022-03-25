Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746BA4E6FC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 10:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiCYJLe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCYJLd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 05:11:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819754BFCB
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648199400; x=1679735400;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TPnwCIF0nkgCIzaiqH4WwL3G6074pFQYi0mDoe8ngLM=;
  b=idrgWvtBIsGHiRql43IELysbCQV81V6H3ghsbM1d5jl/HJRiFZTPPYxd
   TDqyde6Iw/oS7B7DasTIG8x+i1gjRh9/DjGmsLrM7WT7CG7ae3PnyKgqp
   XcC08hty2+Rps0EkYInK6q3eGb02A57HU/hSBIPX2b8++Rz5xhM3bzdGY
   whdgEoKyRm+V0saB9SzVOjZzX563yv76FJUKc5pBQ9QS+Uf6Lf+CCkaxK
   fWu8yn2Nt8/3vZC5WK7MzKzXXyugi76r/1TnTfR1qbdAX+ZqtUHhxGJXl
   /ay3mfdKtYHkvqWLdRjcUXMxqJdx0BfQP9NEgve2fOCmldl4xR62pmhs6
   A==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="197174720"
Received: from mail-sn1anam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 17:09:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/AH+nutoiS3df92pAFvDQ1uEAXBFiG1NtIqvVSGfAJjQ1A2V7Ukk5rtFNzlA67CMDHtCwoHyCYdQdZyxFhwgCmvpsUh5yH76LyfztB2Fnl5mZLD3B2IW3ghXsRDG1JnrHvzbmfE0iPoXWaH3h2ohridoQKkgbXlb7VEVFrQ+IJJkE07N7iAVaFr2RhQpXZhPZ8vJX3nxXaEjRuurlkJVd7vdhhuw8kuc51fjEKDWT/P+wENNTaWYLEJ3WKQn1Tf/G45eHnRAFrKOcD+OCSEKZGJk3PJ313HroVCJZs6Vvtj9vwPhYpFyzkP82GenbPSVIhKmSsTKnXv56IXlWGGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h/v5+0CFxaukkxiStYviVc1W87Sz5upIXO7gEgupW8=;
 b=YvMQDPN6nVFaf4OVBwH0qz8GOdNq+woN+Is8x+EnPTeW5hY9yPLk4juFb02PldJLCNwph7xlC+f3QI58Rtbslfq/3jMgeYn0mPNdFRga4un+KtxuCX2gfmrl+zYBl96+my7WBWsrJSVRNYtYkzQfnwqFNaxk1qoymUb4QWQZtgs9yh4n1xd+b8sfP83sk0bQp6tPXWy4ByPJQkC6LfZ38eqxZeRi7t367o9XHOREeBaX40x9BwqiMoeluKohj+IWNWKkkOPh6kI5wYInKda0V1maQz3S1Sv6TkNQTPTCgPLxtr6z0oLUQ7v7vVV5oWaO2KOLCrkTvkp+6QRoEFF0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h/v5+0CFxaukkxiStYviVc1W87Sz5upIXO7gEgupW8=;
 b=kzFS469FlHj5EQA1FDiUs1bSp2F2AJWV3RMRtCMY4/ZYtnr1QadPa/01DufI+gSLv2RrMQI6Kt1pVydS+w6Xe6IdhyrWGxqL/4P8bWfK50bS4Utl0lt7Ezd0uJkqiSBYo/tpzIsIw/2cV2EHALvNm124oLF/xKMfWuhjD9eG9Hg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6870.namprd04.prod.outlook.com (2603:10b6:610:95::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 09:09:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 09:09:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Thread-Topic: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Thread-Index: AQHYP5/P/QHx4D3LGkWFU1UMp0fg3A==
Date:   Fri, 25 Mar 2022 09:09:56 +0000
Message-ID: <PH0PR04MB7416CF5DB1670FF12D823D779B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e0f2b14-dd29-47bc-dacd-08da0e3f3b5c
x-ms-traffictypediagnostic: CH2PR04MB6870:EE_
x-microsoft-antispam-prvs: <CH2PR04MB68701271EB39C761118258ED9B1A9@CH2PR04MB6870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IutqO6m0w6Zpg44v9V0OAB0JD6eHbvdQ/WujJwaB1ek8gbWKM1VxzLv5Bb02OQUrqeCLGPkqw/CRj34prv+A9S8QNBQwV//HJNesFR916jZZkOJ3HtPSBHD/6hD2ZRHyImR/R/PX4u9HI9fDH//8PbatSyv8o4HbGZKJab9TNui8GkWZ5jGAvyGCTSMMIIj/cwJB8Oa6GF5x85IZkB64dZ+imRMBlN2nrp63tlleBiv8gCBeiWqEK7Eg4azkieWen20DxKflVrHKupCSm2zG8r5kJtkjrMBBpyCYUBNvtq0W/8ucgzaCjZ2uVSpBnTqNUC7o6bfklEpO0pkQuA3ExFzyh5ZuWboQZwejwgCQOq73Nz6QH9mN10fpB3iHUqcalBYKWC6wOmGheU+Yno5XuRN/GSvsfRK6KY3rEmbMjO41DXCUHfrZRmjuQDP+sN4Alpg1FZ++to8s3kOWfiOVrcbgxEBogMFvOFwiOGiQYXDtfbDvRy45w3XVdgy7erMxdMSQyg9bF1X8Pat2uzmj0d9+OpxTH4rLGfPabsydMOFt6PEKXr4WY5MrviZbpS6utfVfKMjUC+3eYTdXjS9yQsqUoe8o/Uu2KBHQWkQgXTavYOhfCYL6C6pg8YTaO4PqFppthDvUOP8irJe2GeOfmPFS0qRKjZA520LD0isjN6/tu1oINKWzAZiakyI29RrY6swe4j40aOORqtGDBrYxfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(64756008)(91956017)(66446008)(66476007)(4326008)(316002)(7696005)(86362001)(55016003)(6636002)(83380400001)(8676002)(52536014)(38100700002)(5660300002)(8936002)(82960400001)(4744005)(71200400001)(53546011)(66556008)(110136005)(66946007)(76116006)(2906002)(508600001)(6506007)(33656002)(38070700005)(9686003)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e4LkbcMZmuMqyhzsjHZtbG6Ypj6l4KHCiLd1MsJrfpbUKiDgiUt0chEkjxvS?=
 =?us-ascii?Q?0CRmYPfyvXLWl7Irpl64rpAimvaFzuVTuYLzQyuTqVc3IW1SplE1stzBHdAE?=
 =?us-ascii?Q?2cs0b4kYMwRt4ffSMjIM3keDI0AbncNjly25HZ04fLTAH0rCsXu2rICVc4bu?=
 =?us-ascii?Q?FYb0zRVZHQlSQJd8lW+d7QM6k9oWh92ZzcO4SzE55z+0Swn4ZLNkOE+BlOvX?=
 =?us-ascii?Q?OhfnFXhw1qrwo9f5P5nral3/t1qeoaDYCfETEleRoMJ5Mg0IBiQXkmICAZkf?=
 =?us-ascii?Q?X/uNxayqFl/WNTRsFjAawePDfTZxSvMN56GEjTZ1zB5RgN1cGqb0VKQzypNy?=
 =?us-ascii?Q?pnfC7w0THJ/aSgVgbmablrO+mmxx6LOOO/iIIBpgLbUav2Ykjiu61aIquXhp?=
 =?us-ascii?Q?6oALd1ZDOxM8o57Iva4rucu9CtwbOylbgqDZ7Dezk/mPCJr4q4QcB/XqsSHW?=
 =?us-ascii?Q?JPTW75LT/UHXe+yw7GiP5Ke4lHQmo6WUTDWfXxwZZkG7+SRXeaGjuc8KkAWe?=
 =?us-ascii?Q?6lCPwR16A5FVAGUy8GP1R5sOjbvlTCCnuQVfnlqPlq1NuiPRTVDWt6Zdiv7e?=
 =?us-ascii?Q?8kdjfitxfy4HcYqJXrqYdHsHau+Ca8uWTonsqrRE06VPEguNXmDZddChq5LW?=
 =?us-ascii?Q?H1pVylWWHiG3fghwEHv9KeSjxGuiFgr8k+AucgtjkgHck3cZr+IH3UmUvhfi?=
 =?us-ascii?Q?2wMNgU9DrOnyqDgtVxSfH/DKw8LNS2n7p/xPhvLSExANv+rcnh0vLOmAEv/N?=
 =?us-ascii?Q?8eJtVw/UqxR+adH29WdowEjIbp7P/7qQWHYZXULLiDgDeKBzjnx1adMbDXDJ?=
 =?us-ascii?Q?pyRNRdPo5fHJnJ6vA/y4oKNI1ELccYSZ9aKzIGajYUanmwFgUrc71ZOuRzdG?=
 =?us-ascii?Q?uiJR1LAK1HuvWdEkXGgFo8weubOwSfsdWLfcCPTDpBWvy4wHwpKWuqYfxPuk?=
 =?us-ascii?Q?E3dmd0MM3tK8YzhP/27qFloLCmJGU9MXNZe73iWeIZZw94kAN6yzCWsgd+vB?=
 =?us-ascii?Q?cEcss8PcGpj9P1vXdG0wHtfkTuZuFvCrBZCs282EAi0raqull9+uwb/FtxEc?=
 =?us-ascii?Q?AK+CVrryGeRq3uYdxrf05ojp82EQFgk79wu+2MeFJA0FDNxVSYJNRoY77S0G?=
 =?us-ascii?Q?JEMPHQxLWLO9qeCm7rFyy84mbu4oefBVP0Ntw2fBiHAae67hVS40pnwmITT1?=
 =?us-ascii?Q?XYPeICNkvHSuJtW/u6neOPdEQxi5cujQt9VSuupIVirM47JG+bymiS6sPKGV?=
 =?us-ascii?Q?Uvk1k1DJNsPMTsvn6blg7aqAMju2bPtNOaKO98aapayOLWy2eAG4RoVcfdJa?=
 =?us-ascii?Q?92dc12ftO4ZX1syD5FbV56ASQYd0bLKLsR3bhNWMhsZXY4eZIO8VE0UQ0shu?=
 =?us-ascii?Q?ApqB8DnpSB5TyjkaeBkcOQmw9WXuiWYl7g2fWTkZZnrb6G+D20opi3bIjFR1?=
 =?us-ascii?Q?KVDGMvGhUF7pYlPIGc9kT1JZq6QynppSW576RoSBsW4mlMa8AA+T4h4BuFgE?=
 =?us-ascii?Q?usybU4tFV89lbI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0f2b14-dd29-47bc-dacd-08da0e3f3b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 09:09:56.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTLGVJcdnQ8P3ujxc3fbX2PYRT4u8s7CxE5IFJG4ig9rwWfr7UZr9zvkz9xr1po3t7rsTG8NcdYX/apies8WZOkYDgzuxtRFvPLFjyPLbNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6870
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/03/2022 17:54, Christoph Hellwig wrote:=0A=
> Zone Append bios only need a valid block device in struct bio, but=0A=
> not the device in the btrfs_bio.  Use the information from=0A=
> btrfs_zoned_get_device to set up bi_bdev and fix zoned writes on=0A=
> multi-device file system with non-homogeneous capabilities and remove=0A=
> the pointless btrfs_bio.device assignment.=0A=
> =0A=
> Add big fat comments explaining what is going on here.=0A=
=0A=
Looks like the old code worked by sheer luck, as we had wbc set and thus=0A=
always assigned fs_info->fs_devices->latest_dev->bdev to the bio. Which =0A=
would obviously not work on a multi device FS.=0A=
=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
