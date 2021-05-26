Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C0B3922FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 01:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhEZXFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 19:05:33 -0400
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:9866 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234343AbhEZXFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 19:05:32 -0400
Received: from pps.filterd (m0118789.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QN2XXs024616;
        Wed, 26 May 2021 19:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps-02182019;
 bh=59zMvjLYtjxtzxmJYFZlATLpi9qEW++KvuOcemhcgvQ=;
 b=jhBkG9PU5zdwgxlnd4vgNfgI/kjMZ7sFjiwJMH8mz0TLhCb/sDtgsMr3xMSnmH+DiGs0
 mx6LnRwf6CwWdSVWPdNkqm/3Pzsdx3rnRBhlXZhi+ciagLFbh31ViGq17eDzjFavPlDT
 S6cfOsEmGGlyVT0PoK4kpxyLz4ygwq50ZhmxLbytJ9OWNTJ3SkWba9pmOywg1HXjIv3U
 MZVoV0o8gAiWqDWLVItvfjaMUrzVcSGY4ZC6W7S6RS7m36N5N0+G7RJh7aI3mOpRG4/w
 gYkCBi88JMuYnVTsadFitUiRqFJj2RABDOEt2QAYy5nWu+8d8naw4TgOux4Vki4EbBYu 4w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-002ab301.pphosted.com with ESMTP id 38snrk0r51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 19:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXDoT/8Txq8vnO0gimqH9mhk7rAsalKTtg4sDM4gGPHLXXSTSOr7BHsHy6FLHmRI5Qx017y+yW3ddU43kLSUueG9jQgNGSJlWNXIp7nHBHZOVO0fkwusb6Y8l4hhobDbkaws6d3/blDlNdKmuTIpQmMBXVyqizEyLjefzn+g62zCoHJs78xE7mQ5xe9uz24217DDWrZXSMhMPjVTQH41FjKTkrF9V2FmwSNRFmhRIgFW9pSOgyWENXdnQpIthmt/1fzOHWCDGJ7ouUEZqTJTEzjVm5kWhhwQs43hC44EfJq3U9ZU13vhoxT0WXoou8V+nsu1saEfwSWPtTQZz94a/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59zMvjLYtjxtzxmJYFZlATLpi9qEW++KvuOcemhcgvQ=;
 b=ciVCivDBIgTCyYq7PRAgmsLOOIQu7mkynSEyOiz3zNA3UdtVOcNPLg+k7JVEWwCddnOi7qnejSI1mTGsK3KajuMu4DAM4WQFiKlGac3/fmkaywmF0e6tjuKnLJf43dqQozYIFCXYambnWI21cCQab5tm06zkSBTKffWo8E8SuQN6Sw068rNStYcig8r1HEU9ZSWBUTKdEs5sxNFRYbmMk05is4XfsuKDDpEDq8nWn7Z82dEtSNS3Buj6OOiFy9KzXEQzvgIchSL3zeiwCFUEwW3r9oHxchXu0rk4ikU/Wd9umf9rlCz33AQB3gC/xB/qoT14tXZwwEyd2U16XqYU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59zMvjLYtjxtzxmJYFZlATLpi9qEW++KvuOcemhcgvQ=;
 b=LegInQN1I7BeGqvCVOKXioi6IQ8Mvejr9BdgtykrpgAU33C9LCItHzrcfQ0+3nIkBn/9dwX5zV/mZtoecCeFAOf2QGavQlzlmB2a834QJBwqlenUBls2d0ehonod6gTj2jhALiEqTlJgZ6PA0lrl1yh4+qc2juJ2Ya2rhadMBzk=
Received: from DM6PR01MB4265.prod.exchangelabs.com (2603:10b6:5:22::33) by
 DM8PR01MB7141.prod.exchangelabs.com (2603:10b6:8:e::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Wed, 26 May 2021 23:03:52 +0000
Received: from DM6PR01MB4265.prod.exchangelabs.com
 ([fe80::31ae:277a:7c6:644e]) by DM6PR01MB4265.prod.exchangelabs.com
 ([fe80::31ae:277a:7c6:644e%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 23:03:52 +0000
From:   "Gervais, Francois" <FGervais@distech-controls.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <FdManana@suse.com>
Subject: Re: read time tree block corruption detected
Thread-Topic: read time tree block corruption detected
Thread-Index: AQHXMvQIVkE2UJzwZEu4ya+WYER7y6q35F6AgAPucjqAAAh5gIAAFd71gACzewCAAMlBj4AAq2MAgADvGLSAAJYeAIABAdYbgDX/SWA=
Date:   Wed, 26 May 2021 23:03:52 +0000
Message-ID: <DM6PR01MB4265FD5C32D07B4A4D0D9CA8F3249@DM6PR01MB4265.prod.exchangelabs.com>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
 <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
 <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
 <709d1a70-e52a-0ff3-8425-f86f18ac0641@gmx.com>
 <BYAPR01MB42641653D21CE9381EDB7CD6F3489@BYAPR01MB4264.prod.exchangelabs.com>
 <f88a4913-87d7-830a-04f8-9af860abd747@gmx.com>
 <SN6PR01MB42695BAC2335150797F758C8F3479@SN6PR01MB4269.prod.exchangelabs.com>,<86123bb4-08d4-5de4-b8cb-b23677062468@gmx.com>,<SN6PR01MB42691A820E13CB9CF356A690F3469@SN6PR01MB4269.prod.exchangelabs.com>
In-Reply-To: <SN6PR01MB42691A820E13CB9CF356A690F3469@SN6PR01MB4269.prod.exchangelabs.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none
 header.from=distech-controls.com;
x-originating-ip: [174.92.177.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4daa94eb-86ea-4c6a-157a-08d9209a8799
x-ms-traffictypediagnostic: DM8PR01MB7141:
x-microsoft-antispam-prvs: <DM8PR01MB71417A1EB3AEBF5C2684EAACF3249@DM8PR01MB7141.prod.exchangelabs.com>
x-pp-identifier: acuityo365
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJzn2xv4Em0HlrAjA5ZVryRtpyXVfvHmsVF1aKhDyeuqIAPsld6a+w++uKAmIAsGvD2H1OvMhCtV4xO3CzeoMKGsCAEYzzZj7WumNJpdSizHUF7MFNiwJJ6u7jwMH8lubOHsIo0miRguImzn4H11KU7YwpN8h3aGMCJ2K1HAYdxj0mpXpzDDMg8gR8Nl8jlZ1PmWiBy2Rb483c8wslYnmro0NskE6wGUrOwIFTv93RL5Eees0gY/dwcTM2LFYq95kOPpKMNMAwEujQgjOS4hMPNwNXwZXloZ2DkuHQJ9zoNJunIyxxLBVhCzzrme98QZZCKLEsf+qsDgxJW3N12C1ATip3GuYFGF4j7u+TIlpBYgbSQM4BgxHrU22d1XoiMbd+2Op0P8z4zzbwbB241wJ5dNlKQDjYxMHMj8fr+o02Osp1ev4JEjeCTOz4EzsN57XTlH+2bSUdn4GmJMXvpNc335o016bZc7GycLFU0WaqAI7v8A7wgzeKUMh76fRH6M84Z58B6eWtJDAx5uPtST3qUaAj30I0fs0KguTOcJMQiiLbYXr+3mWHO6Yh7H1Fd/Gtca2MiLP4wzPJc0ejzmFO2WmgvI00466upR/MCRp5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4265.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(5660300002)(52536014)(66556008)(66946007)(64756008)(76116006)(33656002)(66446008)(71200400001)(86362001)(2906002)(9686003)(66476007)(83380400001)(8936002)(7696005)(26005)(6506007)(186003)(478600001)(110136005)(316002)(8676002)(55016002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?pD87s4Z6TCA78C09p6za6S2AYwhd/DmuhI2HRfG51YlXecS5CRFSxXpVO1?=
 =?iso-8859-1?Q?VP2DGPBPKM16lCalqlc+E/qRyhHw/1zJVhak/tiSbkPZwS0mRHT8gkBtIG?=
 =?iso-8859-1?Q?I2X4KLZwmSMzXgaa+3RxkijASTBMXVmtG/1cV/NRxXJFDB0HhxmMiBB9QU?=
 =?iso-8859-1?Q?dzKLzt+ziA8T9u8FCU5Kj421r42Yt2OUOlFj2WtpmJ/Y0hStRFR0aVfcQ4?=
 =?iso-8859-1?Q?3BuARi7hrNvwctlebxKlfYNr4///S0Iu0ixTN2Bw1svnB1l3d9EuKGSuB7?=
 =?iso-8859-1?Q?RqtksQd0AZQdbQD65iFpHM5bDXAcVJxxW/6k5bHxjFlrs8dCYJltEUxam/?=
 =?iso-8859-1?Q?qWN42TFYlK9/UcZfRG2rLpbABST3/OlFesr4JRJ6Bl7giafpd/7D9t7gvt?=
 =?iso-8859-1?Q?ql9vuizv+6JYotjGVwtcv2e+7A9A+BKlwd3km956H50D+kKNTHMP3cWlmZ?=
 =?iso-8859-1?Q?ctUWBsj+hPNZr2KbClR4XQ2q3lyZOqcchKrFifI9X5VBJW812RW43UhiUL?=
 =?iso-8859-1?Q?JZvb7UR4oHHtMHP3yZz2JxNVz6yJUxmuezC7vRjju6E4WJOFcV5Ap85Q6R?=
 =?iso-8859-1?Q?sgzvPki2IF5wUVKaPmQYxrpcTonYKIGcYJDUHd9tlnha41DFx60zV5Emz1?=
 =?iso-8859-1?Q?b9bk3h3T+Ktmw6IFXqXwtTNvVNyxCT/N0PTbFVnh6E/so1BSkf5imA9+XD?=
 =?iso-8859-1?Q?q3QJcGuV6miqvdI7TBYScUIkMbVSqUaLcdRzhPcTnRtOn9LXzFpST2ltX/?=
 =?iso-8859-1?Q?EOvy5DJq0SaFj1gUu0Djd3+yVWMcEiZOUJ6vFjwR7Jw0/bkyp0bognlZQR?=
 =?iso-8859-1?Q?CSZAaHVcMGMr3VhwQYB0RiJlCGCJcmFI4Qhvz+r6k8uPUfvpOFc8ZnRVYN?=
 =?iso-8859-1?Q?2qxab/iSzP1BfGlBQSRMXBSVRAQgBpQUkEkDhwHNqsi6YSHYFDqaDmO/pM?=
 =?iso-8859-1?Q?t2cdlB/IrBHpL5RcOTQK2/v2EdrUQ0j5Xc1F+Ti19+hQqCAYfVu0Uz/dcL?=
 =?iso-8859-1?Q?grC81y8PM/SBIezN13bdYKfj3kLRFw/W/2jOMlSe/KZ50LNRpnvQhQ5Fge?=
 =?iso-8859-1?Q?KGcCKSJfRlC7kqcRLPvLnolUxIg7F2vpdvBSBTVgiEOBk1JnMsfVIBmoro?=
 =?iso-8859-1?Q?EsmSwP3qzz+/3Hq5zeN1zWjJGhhQmZ0mwa0c7W67I2UOhm+KY+RLN3KOpu?=
 =?iso-8859-1?Q?R8WgxFulh4U4sfcNDksV07DN3+AnkmRuCH2Go9JnCAX671c5kZ7gheWm3n?=
 =?iso-8859-1?Q?fhba5aDnrcLlpZlvkuBnsn7Rm7g9E/nciu6xDuOiOw6hEovbn5Qye7CFgG?=
 =?iso-8859-1?Q?I8vFEySrkIg4jxdCwSOpPDZK7i9EIH6Z7tGk0hxDBlKC4xQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4265.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daa94eb-86ea-4c6a-157a-08d9209a8799
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 23:03:52.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8f8aAjPso7/moUEoTWKu42jK3w6RdT/plSogkSieT7/pi79qfnAvc+M8QRjCmgs5vdNDlaLOmr0OcIAdqQ7Lvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7141
X-Proofpoint-GUID: zSKwXK2u9pl6MNCSiTMYoMdo5v5IX15k
X-Proofpoint-ORIG-GUID: zSKwXK2u9pl6MNCSiTMYoMdo5v5IX15k
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105260156
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had to re-send this message as I forgot to send it as plain text earlier =
today. I apologize if some people receive it twice.=0A=
=0A=
>>> - Anything you would recommend as of configuration of the device?=0A=
>>=0A=
>> You can test using dm-logwrites, which really logs every writes and=0A=
>> replay it.=0A=
>> By using dm-logwrites, you can emulate powerloss for each write operatio=
n.=0A=
=0A=
I'm in the process of putting together a test scenario using dm-log-writes =
on our=0A=
device but I have a few questions.=0A=
=0A=
1. What I'm thinking of doing is do the firmware operation that the device =
was=0A=
doing when we got the corruption but this time using dm-log-writes and then=
=0A=
replay the log entry per entry.=0A=
=0A=
Will tree-checker catch to issue just by replaying or do I need to do an ad=
ditional=0A=
step for every log entry replay? (btrfs check? btrfs scrub?)=0A=
=0A=
2. From what I understand, our corruption of the log-tree can either be sof=
tware=0A=
which would have requested a corrupted entry to be written to disk or hardw=
are=0A=
which would have corrupted the entry when trying to write it to disk.=0A=
=0A=
Debugging with dm-log-writes would not catch a corruption by the hardware i=
f due=0A=
to a one-off glitch or something right?=0A=
=0A=
>>>    - Should we run a newer kernel than our current v5.4?=0A=
>>=0A=
>> Definitely. In fact my fuzzy memory points me to some fix, but I can't=
=0A=
>> remember exactly which fix.=0A=
>>=0A=
>>>    - Any debug you think would be useful to enable or add?=0A=
>>>=0A=
>>=0A=
>> Tree-checker, which is already enabled by default (in fact no way to=0A=
>> disable) in newer kernels.=0A=
>>=0A=
>> Thanks,=0A=
>> Qu=0A=
>=0A=
> Thank you very much,=0A=
>=0A=
> I will report here if/when we get more information on this issue.=
