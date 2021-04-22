Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E906B36826D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhDVO1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Apr 2021 10:27:18 -0400
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:33688 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236333AbhDVO1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Apr 2021 10:27:17 -0400
Received: from pps.filterd (m0118796.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MENTvD019543;
        Thu, 22 Apr 2021 10:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps-02182019;
 bh=VbianTkKg5ZYeAkTfkv8aLP4ZBM9naqEnvW7j0N4vAU=;
 b=ts1wT2Gb2QwiB+DoPNoOpZAW9VtLmjH7g2c7O8fHRhcWukZSF/DHUBK0A6wryhJUNRY+
 IvmTfDNwEPh9yCJ0fbLoLFxvMq8KOAC4m90kbrj8Uz2SMtjroOk22he7j+dxm8E11/x8
 ByejmV3vLTgHHS9LMiKjyLamRaRwdVkOfxbhTKAv/FssXAW9GXZLJmIK2znPPiki5GXL
 +jTbXjpYhXjmoBFoYsKVmPdQpudbEiXVjXgTXVLJISlgXorXVb4M8e9UtJ8XtSTSQVBa
 T/Yw5u0mVf+RU7BL1xxAmERzbKSpB+p7fXpuwyhIYtk3r/3CqDYZcJ+80U6T2tMfpPPN GA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0b-002ab301.pphosted.com with ESMTP id 3835kcr95s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE5efsZvZKiN1VcD24OxMEXVsTd9PDvjhrKreQNofHHDGTsZq9muDC7v1TG67iZjA7I722dX0C/RyqfyHAcrHadeWUyQBEzqmT148F6kCXU8O7kLqhxzrkHwIvnNfjNzHSOfzVyofRKj0fUV5phL/o8o19+1DZqO9t40ARJvwLKqdUOsXD4ZbcDyY+x8bVWErNs32c+JiwbJV586YQtNkXfoHS1NYr7jQPrAVHRLbCxzYzUA6yZzKBi1sDDeQ3cCD34C/Z/KI+5iMWu/m8WbjpVmUcjRTzTAELXoFFUGMIwCD98T4danCkbsyAlIo2DCRCEb5PlQOZ1wmqgnPmtOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbianTkKg5ZYeAkTfkv8aLP4ZBM9naqEnvW7j0N4vAU=;
 b=Zmuixu9JaRPn2auMZlkMNtzgW08ZDl8V9EZ0xakJbJqsV29PjE5bQH9GhaTBWAAtwOrPEgmNkxXKNs02z1DbxKFOMLg9TWyaG40g6bl/4bePXzMWcIx/DUHfHLk8+1KXd+VBo6eFFNvB+cNp3c4RtfO3NQNBSFI/blxi36GZxMNj5nt8dLgvcNrZdqFbFZT7NTEjfZrUyGLAzb5xGCRCQXVNQQLU/fWE8L5bB4HZHQL/UBZI+L/3SURKJqB6nmHZ9Ami+OVls0+GNVphrnMGiEHwqodyntV63YLsJw9lQd7vOlBQbqeWuaC8jYnkQvVOgvw3wbYiIvtiZJssWYQ8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbianTkKg5ZYeAkTfkv8aLP4ZBM9naqEnvW7j0N4vAU=;
 b=H0hN3/Is5to5Qtww08jQoKMuQ4LjZRTP6uesyGaMxLCiprzcRe3BjBuoODf7CXCx1SqbWoWKAoYSeVVe5eHnjwo61UCqWS4sPomK+9fyNqFFTlTKpTX6iZLnXMFd4rUk2vRAsRu+hTPDuuypFbDZf8AT+BLquO5ddNBWTV6cLFQ=
Received: from SN6PR01MB4269.prod.exchangelabs.com (2603:10b6:805:ad::23) by
 SA1PR01MB6543.prod.exchangelabs.com (2603:10b6:806:1a7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Thu, 22 Apr 2021 14:26:35 +0000
Received: from SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b]) by SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 14:26:34 +0000
From:   "Gervais, Francois" <FGervais@distech-controls.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <FdManana@suse.com>
Subject: Re: read time tree block corruption detected
Thread-Topic: read time tree block corruption detected
Thread-Index: AQHXMvQIVkE2UJzwZEu4ya+WYER7y6q35F6AgAPucjqAAAh5gIAAFd71gACzewCAAMlBj4AAq2MAgADvGLSAAJYeAIABAdYb
Date:   Thu, 22 Apr 2021 14:26:34 +0000
Message-ID: <SN6PR01MB42691A820E13CB9CF356A690F3469@SN6PR01MB4269.prod.exchangelabs.com>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
 <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
 <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
 <709d1a70-e52a-0ff3-8425-f86f18ac0641@gmx.com>
 <BYAPR01MB42641653D21CE9381EDB7CD6F3489@BYAPR01MB4264.prod.exchangelabs.com>
 <f88a4913-87d7-830a-04f8-9af860abd747@gmx.com>
 <SN6PR01MB42695BAC2335150797F758C8F3479@SN6PR01MB4269.prod.exchangelabs.com>,<86123bb4-08d4-5de4-b8cb-b23677062468@gmx.com>
In-Reply-To: <86123bb4-08d4-5de4-b8cb-b23677062468@gmx.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none
 header.from=distech-controls.com;
x-originating-ip: [76.67.142.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ac37c8c-6b15-45fa-8a79-08d9059aa1e2
x-ms-traffictypediagnostic: SA1PR01MB6543:
x-microsoft-antispam-prvs: <SA1PR01MB654372A4D98F959ADD37548BF3469@SA1PR01MB6543.prod.exchangelabs.com>
x-pp-identifier: acuityo365
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/fF4HiLjzqcNM1RMa6cfEw1Rf58Ie95gbifcxvg2xHovIV2xVC7gamOx8pzxN0Bio7GitKWsGg8W2v15RVfpGTKMG4dF/CowAKYCpYDJoOkSEXwxeCE854dPBXq2AYzBJXqv2EnOmf5EemORF+2qqaB7+3dUPAj186gHCnH5SaaYD2IMqnBBHFkS4KYJa98dUt6fiM5Ey7MGyiibakWGasI6eCFS7U0pjAPugIkwm1GdT0zR2OhrfrTBakL7joAloqLQoWMf3ySiLPRR0htVzyFESsrn0cZ1/AFwFn82yMSnFBrZfflG5r10UTRYZnzodT7qVI/3XmooKdnRmbXR0wiEWks1H7cikwLAlE7AJAyugVTGhTgrbviH6ZIBqEEaKW8NNmoofN4Myomf9y3Ze9dkEt7QGK0HBUVPrTDN+EnBBc3AruF8AEggplthV5LR9/R8RDOWReqp9flYFL9nlRsD9IbvQ2Vzs4dC7+u+/UrdAej0aHurQQKUpsaE7R0Qazd95cAH5k2I575gBj330ZVPnOkoJvaGLyJ7c1yqFfwH/AddDDca9rlxZgKSlJIHb9WKifVxPkhUwjyZOVVhCA8+Ug5FyRVn5J5toI+ezQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4269.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39840400004)(396003)(346002)(478600001)(316002)(2906002)(110136005)(55016002)(26005)(52536014)(186003)(122000001)(4744005)(6506007)(5660300002)(38100700002)(66946007)(66446008)(9686003)(66556008)(64756008)(66476007)(76116006)(7696005)(8936002)(91956017)(33656002)(71200400001)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WxJK/aymyOfJ1tlUTu2ztIwrDicnZFJoIhNsVtkVS7xh3UMWqBqEAfWW+v?=
 =?iso-8859-1?Q?SRBqf6uksxyjDvIgFZeNl7jOcTrDBIRaBMSlUNOmm/xtvRZPygtXPL5nZh?=
 =?iso-8859-1?Q?EnIp35+0ZPUrkLYRZSSyy1oVFIshsXYE1JmSCXNOeOUkVh91Mrhwgz0zFU?=
 =?iso-8859-1?Q?8Or53LSm92xpfF3GY5cpqO4XshimZkWQ9hfC2YjNBPTVVbW6BJj44nWIhn?=
 =?iso-8859-1?Q?dnyiXOt9c+UZmlUNQAqlM8qfrXBqKykzs3TOghXUAoyeiZO3xM1ei/gCqr?=
 =?iso-8859-1?Q?5JCL86lIC1b3Sy7BkQqJlHn7DEd1OMv1IOPZegu16CM/coDLLdUg/jt3e5?=
 =?iso-8859-1?Q?q4mbvOud0WdOFjeP/2k6dBUsL5lmpNtYopAXIDSWp1SDXqiYO0i2rOdBxq?=
 =?iso-8859-1?Q?R9e9KRIpoFICxI9WmzcmZeL/KUxrCYYKjjQ1oDGB5akKJd28vc5dTRoxMQ?=
 =?iso-8859-1?Q?J7XYTkNit2DtL+M8Ri1fpy8UcSCbqZo3Sci69Fp1TJLQXBPzwILKhAZgcb?=
 =?iso-8859-1?Q?55NBhroq461kSMuywNice9XOM4vQfN2v1wGwphsobX518+PZpRWABEA9LK?=
 =?iso-8859-1?Q?HhhUzbHF5mHmNGvts71OrPEsubVptIHxshX1tkl3nx7M81v2sySbWzQCop?=
 =?iso-8859-1?Q?gbB+onJ2GCmpf2llBo8rrfNCPLwFGT9LN5abbikoxCx95ajTUFSdDjtR+/?=
 =?iso-8859-1?Q?G0o+hu0/Cf3ugVkGE82aCuBANs9EowFqnXvwmo2wW5c7qSgE18NfT5dI7C?=
 =?iso-8859-1?Q?jHor30CZY/lXccwXxhH6axYAODS9EDT4Id0YXm9Z78WTObuXTqcBLza0Vc?=
 =?iso-8859-1?Q?UU88Xd0AqzVtIjerzo6QL27bBsJERKQvIjEy/t4o7KxSoosxXymefilk7G?=
 =?iso-8859-1?Q?H2NcU0jb3kXNDb07blq3XLMlxdFlbGsMFG7qUCq+oxQgv6bCssbzo6WybB?=
 =?iso-8859-1?Q?x/xpbmfI3+obRDnvv54fVfzFr2dl0Ph+p26QfGjWdfnGFK3qcF1ukX4yyI?=
 =?iso-8859-1?Q?0W1ocDI2SN6zBkfn7IKC1IzwVugCAU+4VEOUe1m6Kc1sx+PZUF8eViEM2v?=
 =?iso-8859-1?Q?IvsCNhfeTPioSFyDto5ruW9JMpIWApppU9OOYXzFqD2bhhwy29SkorNTUd?=
 =?iso-8859-1?Q?MX74PqBF11n9KlEA1t7dCFq6e3vptwFWaTAcbacPt8+8woWUBlXlHxUPMD?=
 =?iso-8859-1?Q?USFuEYsHABCGTpfD7qHjF/q9QwXII+81vSCBT/vhzlvQi9NYSsEpu3EUg7?=
 =?iso-8859-1?Q?TPY96+pgaIZNIPqcplm3wOcmHqxZ/7jY3D/CmiEAs60CPhZtddZN15wwy/?=
 =?iso-8859-1?Q?6+N1sQ/8A+/L06kPGfrfm7laDTYXooxgi36oCda8JX2yisw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4269.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac37c8c-6b15-45fa-8a79-08d9059aa1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 14:26:34.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KswvR8OwJbhgrDg1MdvMJ8XhRg0l4jSIimaky480oqlD358Usddw1+wrPU63bSM5XF4tDiRJu7R3mj8WROIkMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6543
X-Proofpoint-GUID: CPbCywqE8bA-NdhtTd3cMMaP1eYscCWP
X-Proofpoint-ORIG-GUID: CPbCywqE8bA-NdhtTd3cMMaP1eYscCWP
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=973 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220118
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> Alright, for the next step, I feel the best is that we try to reproduce =
and=0A=
>> get more information as of the events that caused state.=0A=
>>=0A=
>> A few questions ,if you want, before we start.=0A=
>>=0A=
>> - Anything you would recommend as of configuration of the device?=0A=
> =0A=
> You can test using dm-logwrites, which really logs every writes and=0A=
> replay it.=0A=
> By using dm-logwrites, you can emulate powerloss for each write operation=
.=0A=
> =0A=
>>=A0=A0=A0 - Should we run a newer kernel than our current v5.4?=0A=
> =0A=
> Definitely. In fact my fuzzy memory points me to some fix, but I can't=0A=
> remember exactly which fix.=0A=
> =0A=
>>=A0=A0=A0 - Any debug you think would be useful to enable or add?=0A=
>>=0A=
> =0A=
> Tree-checker, which is already enabled by default (in fact no way to=0A=
> disable) in newer kernels.=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
=0A=
Thank you very much,=0A=
=0A=
I will report here if/when we get more information on this issue.=
