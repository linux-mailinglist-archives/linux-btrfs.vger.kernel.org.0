Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76A033AEF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 10:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCOJkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 05:40:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33726 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCOJj6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 05:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615801198; x=1647337198;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=p/jKsd4V94x8wAasDDKYo9DwIAtolBN006ERbXXqqivk1zQzs05SbDPZ
   ec1k18jPqh/lW1Tetj2FJ3i1+f0MKk7sjTwYGZkG97v4BpJ0XipG2Nxoe
   bu7yatB7EFu2z7ldPwMxM3/cBs6MNL4O9lRYdC1EHaB2RVbqiKqbDwEt2
   FMIuVwVuL5g3oBNV7YgMdwfAwtYTjRFsoKgiJiDM8Gs0cjsiensEmQXut
   uqJuSJwGFYPpVz5PMy8N3caWPg/L3CvAnHmQ8wkj0YxNStkM/qCUz3fsc
   ByeWa2KMfVpnNqdek2kiZF27jp7mRgcQ0egbVNmEOjiAsBxtE0DfjoEDF
   Q==;
IronPort-SDR: y7P4H2GqWuAJLkUQeI9cnlFLb7PEBLc3Nt47TKLR8P8JU5gX5K9Hg1paZnAQZF34dARbdh8cbi
 ks+KIw5d/RDfCHaUSzH5OSJRpZJix8BKAlLfSmcAzSxGD6ET87zlE55IzE+wqAQUyh6K6FhPPm
 iIg/i091udqiCBfHxrguhVZz9JD3Rmexx86/Ybr84vmSkDt3bQiRVGL3XbZN0NFmjrM+2HZLzz
 Am3uECSv0wdFz4nRtfm53tBESdBiPOal99YBRLiQiqHWRjd7tKrM4XD4v92/LYoQrLdHlq+O4S
 zTo=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="162138542"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 17:39:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOrBiC0LRUiMu1+L+yuzjNsPb8rUTDB1PvCc0wCkoU1X2+rH7RhZ+y9uaNfV/F8hUBLy/h3XRn+hciEwuzSM2IzKEGi7GJ+cgrI0I5kBDE67/+dNZq6eW/oaNDlGu6+UknjIV5IUomo9dxB0M1Uyoj/2MpRCBR/lD7PXvl9HVMLojclMP6/tip+x/LfmL4lOMXNbtvFsq3zPXQYicOy+9b0jf9J09yahaflCrV6ct0UjtMSRi92utYHup/EOUwTbpfbivY0liHeLpGcUOQM0uQ8YBhEP8EmEIPMhWxdDx1s7jBXC64ILxdpmfHJ8dF907Uo8ynpIzZTAuY7bNiQEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=emg85lOsLHW0SGx8EixWwAFnAtf0FZGn4dKS6BbkmbaiPXXFQg13p9ofVcwl+ceU0EEYzFbr4mNfmxGfzjoTqLMM3zYoYOxS8RIHr3HMWsyQ8SIbSbyVwBVzChEXmcMnkO+OnaPhrPdadyPnrKmsJDYX5xjmWMZZXaWJRduGv2lXdeEn1r04MhN6i8zhlvJbVIv5rQ+o1/jhhQtU9agPrWwE8TD8agSN3T2wuj4zmeQGZk5agf/P3+IdonvWI/LA0GplLmV03UFLrgk5olRMzQZbGDMUwZcDJalzcb/WAcy/Cdt5KnxfpNP/csq4Ag2Crz/sYhpdvdbltu36rLbCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CrqFJRLkGqVPUI2kgBKmLBdQee9n9KL4HIybDma+A3HYBGQIVap1NXEvkQ6Oh8PzXuW3t+8dktcfI1b1UpxLf2JMuDyfmW/uM6IDkODR/4e+ySa9zWbyFZC0vh3c9Y27ekei1ZnEXKrUXjU7Y8Ug3itKz5W1zNeAnguKpt8/vgk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7542.namprd04.prod.outlook.com (2603:10b6:510:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 09:39:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 09:39:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: make reada to be subpage compatible
Thread-Topic: [PATCH 2/2] btrfs: make reada to be subpage compatible
Thread-Index: AQHXGV211qA33AGy50mUFMWE5asV0w==
Date:   Mon, 15 Mar 2021 09:39:55 +0000
Message-ID: <PH0PR04MB7416E65305D49D1DC0091A059B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210315053915.62420-1-wqu@suse.com>
 <20210315053915.62420-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:6d29:9a36:82c2:4644]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e1e593d-4aa3-47f7-95a0-08d8e7964a95
x-ms-traffictypediagnostic: PH0PR04MB7542:
x-microsoft-antispam-prvs: <PH0PR04MB7542CC8542BE3B6ABEAE90909B6C9@PH0PR04MB7542.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBlH0i7HqzJIyEV/4YGrPr8y7gDplnb2Wdylztg7uE1IuBmCUPAxX/lJCCQlfT2FYBngjSPnuOU0eq2JAOqeuFIF5EXJCLMeEtbbB8NM48a92gLO+MsW3iESnBzrgRm+ySxVkNSCnHPF9f1Ujn2jJD3XeH+VT0wBmj9d0nc5ypXSfHbzz7I/fDq7W8ZFgG/PT3SqX7h/MsGJzloMg5Ow8dgDtZFrmwKA2EXI4B4PtpEZan/0YRzWzyZrKLQ3YqCcQNlSDrHOhDuWiuc39RtEc9xoHfm7aYGDylPZJxg9BbNQSzyFkgdh8y+IBSEdD3xlH2RgnXjSaYLx+0b6s9XNl03FqP+pDxVpzcS7BzE0oBjjE/qxrGIgMGXdfOVAtqVz51hFAi3mkW5UT4VVxDQ5I0LAUIVAf2/t77X2CD6/6YIVlqlY/R1UmXVvLMZJGeUg6X7pe5TcWZ6RYStQzw7+i4hLv6X/ondeXp+9ZMFlXhAR9tygAdBOMQRobIo/2L282VW2anQprE301tEhMqHH3nuGJSWiIE8ENDVR+9kdZ1fvnPzwrD28x8Qv9ML1qKZB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(6506007)(186003)(110136005)(4270600006)(55016002)(316002)(558084003)(2906002)(9686003)(33656002)(64756008)(478600001)(8676002)(86362001)(7696005)(76116006)(5660300002)(71200400001)(8936002)(19618925003)(66946007)(66556008)(66446008)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nNe2WpcWCzREBq9YYiea5LOULKbGnu0bsnz0zY43ummtkdjwKOL2oQpgY84P?=
 =?us-ascii?Q?iSyS9WTcW/bgxgvYe92Ksz39c9dKaSoFA81sMJSiDQCqNFhKXfKSAwQe8u40?=
 =?us-ascii?Q?pOtnmCq3BZ1jY3WxXTBVBODq6OqBGZMANwZ8aqBuVgCSmJCgqw/1m9xKmnUV?=
 =?us-ascii?Q?bxVApigq/wsHPTJ7JB8iPKNd5+tNzIuawDXhHonhr0lifTpDuweOb0CLPm3R?=
 =?us-ascii?Q?XQxoVcysBGFSmVRuzLWO+Fj4xPMrwmy3wy62A0UbvD9Sf5jwyAUgs69lg4MF?=
 =?us-ascii?Q?rTjpp7tl23h12Q+tcYFayeqSOL/RM/ocDWRrxh0LXzqvjd7QNCnmNnDFczDJ?=
 =?us-ascii?Q?78mc+f2yWPuCVneA0ItwcELT1S7SRCMih4ftM4U0asasfbC8ixlD/NEqmpUW?=
 =?us-ascii?Q?YApXZxlaqXlgWFaeqOO/8p84nW9zNjXBGHdEzWkv4yTiitoPyd+ONJmvg6ox?=
 =?us-ascii?Q?hjMVJ2no1IYK0nfJzrzn/jq8CA0FdYq2I0O0DIY5gWDyuX6OXIs7FKvY1jG8?=
 =?us-ascii?Q?Sb0XUEE0Oj/Nw/Cgo5wXKFtdKOiWF6RPrGIYKuVxJuT8alMNladcBqq2CNAr?=
 =?us-ascii?Q?vpEjG/GzMxETR26WHxYXraewByVzuC2ypniepgYSKWGbv4b3yZ0VhBN2RcU9?=
 =?us-ascii?Q?VNaLWhu6r2/f+PEZzI9ew6/h+EZ1ZXrrUCmbjIig6pIFnfxBwZrRcPSDkT07?=
 =?us-ascii?Q?KCplo4Apbmmhs69T7H9q/eugAQYVR8GtH7nQTZ45Ddfl1BtkpDddtd1P63B4?=
 =?us-ascii?Q?Hs2+/fM/NDSKfqI88z73oNvkxrAZJpB8eVHoSrl11p2iX62yuAOtXzQwiZQv?=
 =?us-ascii?Q?pUcUNdPfCXT9DFO2tvtL9toJABrYT8pcz9efQpu8j6zG7fbBzFg1jPFjUEdF?=
 =?us-ascii?Q?xElArnUcu9lwvLE+VQ8+OdB/rExiVNE7h4a6vIZu9zqwfd9TckitWn4093je?=
 =?us-ascii?Q?K4pJFbgSnc7b9BwncjXNoIx4Hqc+AWScnt4MM41zEPAvTZC66r54zVT2rLg7?=
 =?us-ascii?Q?tOkVAEK06SkxBOz8q4PB1bK9oDIkza4iaBDB7Qyrpt83KBLm0UN4rmjZUlBS?=
 =?us-ascii?Q?4/cf9VisH3gBK+Pm3kSY9Q1/mJ6eikfDZMEJFirSnpumsby/WiwBr7O3WYK7?=
 =?us-ascii?Q?bSPYnFmByphO1DX2susJW8AjYFsGUaFqzjHCl31M3NYMUv8Nh+krtMNv+Qer?=
 =?us-ascii?Q?+asNYIZl9oXWUT33iVEPJOrRHJRw43/YnzC73kOTa2EC4PNn+oJQYO0RXPxG?=
 =?us-ascii?Q?Qi+a4GdOoemCGxU+NfnLMFgJRAJhpMFjL2bb1Tw8+aPzUTOu4wBbApjN7pNv?=
 =?us-ascii?Q?rFPMePg7xXf5Hc7B9Qg/Iuqr1E6tDuqGP0S5D5wafIb6TnmnpTk2wzkfZ390?=
 =?us-ascii?Q?nvbRdzV86RcSMLgKve2EKTsqbozoqhvT2R8jwvrin/aGHA8w8Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1e593d-4aa3-47f7-95a0-08d8e7964a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 09:39:55.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmADwKbOOrgrLOxA90oavGHdRuxYFxsX6UsnBM9lvm56V1m+m6O2kTkPkGWsGYmk6OX92Im4MIyhkZl4HIKqjkueYyZsU53KPsW3pa++ghA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7542
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
