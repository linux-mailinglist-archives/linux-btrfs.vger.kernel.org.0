Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF011C135
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 01:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLLAPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 19:15:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726673AbfLLAPz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 19:15:55 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBBNv2Pn029081;
        Wed, 11 Dec 2019 16:15:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=i4GjIjjlP7pYQmibYYqUWVltVQELih5Kp25PtBknoQM=;
 b=l2ET7MKttiHlEYTrA1L5519v3xWSIomk/ascaI65l2V6OwVZzq+rZZFF4k4/wcHyL6NI
 O0npEIVsEUZjuD0RiW//x2hHm9aOb0AA1EaEhUPmeuwF/VQYc2QvS9DQ4i0MuJ3cqZGg
 xN74Dp6M7yVE71dOlwxZkoDFQelMdqq7AWg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wu5w91b3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Dec 2019 16:15:48 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Dec 2019 16:15:47 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 16:15:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bczomAwlQ8BS9J6hbVCft62X4zTihkXDY2gXQFer6N6xOb9OUBVLPw7EQTMgwZUJBy1tfUMp+uFGE4gvhLbjd41EhRrggmTr4rzqLs8tcWdWEr69xj4zejTSXl/Xz5B05GCsygA1JgAOc9FQv3EEWV9Qi2s8VLhDg7THNszB9woMzoKjr6fuqOk6UbyRVex/spG1d4hYBjMmwM1bRMpWGtAxwWL7Ns/sB82FI2xZa7jw/One3EnUh/rn0RCTd+m7zmtvpqarO8c/8AoekRItSp8Bauqi/SmNOkTUMAH939Zjyn/Wo65HJJXqpY4dh3b4OxvXyulHnTk3zB1UAIMuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4GjIjjlP7pYQmibYYqUWVltVQELih5Kp25PtBknoQM=;
 b=JGvit1D+beu5oO4SqMlHSz86FFDvsIqIH0La1wpIae+5HbdPTqGWxgnzlk9+mz24Rl+/8JMvvwSGXUNKb46cseJTor18SDbywc/jJ8hoXI7JNTYOOvwIK8DWuqlHZxkeW/c9kP/SbiJDt2KmiwptcVigdm29eYyZ79t53ChfaZLRACJXJDvTnCwAkm34PtvD+aIBf5u/VFKYlIxE6fDMnKxwXA2nzHYrFdUNRoPpD/IL6/phxfW6QB402BGnWWnRUGgj0W7liJDshnZ6FvVa92/CHZzfnfDqn8xk1EMbiDOaOyyCu6LNhJuT+NTma7VA5BpdG3XaeihLES3zI7QHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4GjIjjlP7pYQmibYYqUWVltVQELih5Kp25PtBknoQM=;
 b=kTLx3ZB6V4ACVQP/HuLnJgkFyQ+xCMQnARGPXctPkMfgSN03XXTcTJbf2NALQpb1mda1iZuCAj1d9V38XZymv+npUaWPiThtynnnl4EJkVLfAH6T3wHNEnIqDy3PDyqh7FbftUhwGqMJxM/qO4u+mh0UcH61aOD7VcusbVUSbqM=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2269.namprd15.prod.outlook.com (52.135.64.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 00:15:46 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::21bd:84c5:4e24:4695]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::21bd:84c5:4e24:4695%6]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 00:15:46 +0000
From:   Chris Mason <clm@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: punt all bios created in
 btrfs_submit_compressed_write()
Thread-Topic: [PATCH 1/2] btrfs: punt all bios created in
 btrfs_submit_compressed_write()
Thread-Index: AQHVsIAck6kHDrAHR0+vq5RPI6M9CKe1oZWA
Date:   Thu, 12 Dec 2019 00:15:46 +0000
Message-ID: <8768C12C-9FD0-4BC5-BB4B-6AC9CB2EE29B@fb.com>
References: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
In-Reply-To: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.10r5443)
x-clientproxiedby: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::9d49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56c015e6-631a-42fe-c7f0-08d77e986f11
x-ms-traffictypediagnostic: SN6PR15MB2269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB226916337778DB606D9FC77BD3550@SN6PR15MB2269.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(478600001)(4744005)(316002)(52116002)(186003)(54906003)(4326008)(71200400001)(2906002)(5660300002)(86362001)(6486002)(6512007)(53546011)(81156014)(81166006)(6506007)(2616005)(36756003)(66446008)(66556008)(64756008)(66476007)(66946007)(6916009)(8676002)(8936002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2269;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YeysmPcQ2eQ8o/91IAX25iVLo4Aqbudr7mwv8zURRv4SehNXTlvFb5Dbq3MqxtaJORt0Zsz7S2o4SMfHCogb5+F7gwbC6WJdATiBQStJ3p1imFIzqCn0lfHOlGv8FsQYMtXbbCLoCLIrSHr6K8z+M3dDDPmyCtXcLv35jxcH40W4+RN/qveZX3Ok/KNxHqrBI5A8PtXEVo6G9Wtcq1LFriul6r+GCofURGGdC0yU3FICQbkOUSIT/7NDSDz/P8elWy9L05nO2CjsgACd70JEr/B+UpMG1AMfDhzj2cntVIKMRXAA9g6f9gQb9n5BXApq3dJvVKuJWpAfSLGLYyRZxHZXwXhVk92hSviHoQ8gXxLupA+uORNRbqTLYfoSUQUrzTL2pmghPdOkS9pFdVys/ZgCWVEf5fbyscpEONGCYZU1xGIeLBM091rXGNoXbAN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c015e6-631a-42fe-c7f0-08d77e986f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 00:15:46.1388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuVSbZ61BmFPDzYo1z7yjUZIUUHMDvQm5GVA3Semj7sX2tNO9MzvehlhxO35jk2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2269
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_07:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=904
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110185
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11 Dec 2019, at 19:07, Dennis Zhou wrote:

> Compressed writes happen in the background via kworkers. However, this
> causes bios to be attributed to root bypassing any cgroup limits from
> the actual writer. We tag the first bio with REQ_CGROUP_PUNT, which=20
> will
> punt the bio to an appropriate cgroup specific workqueue and attribute
> the IO properly. However, if btrfs_submit_compressed_write() creates a
> new bio, we don't tag it the same way. Add the appropriate tagging for
> subsequent bios.
>
> Fixes: ec39f7696ccfa ("Btrfs: use REQ_CGROUP_PUNT for worker thread=20
> submitted bios")
> Cc: Chris Mason <clm@fb.com>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Good catch Dennis.  The compression code should end up limiting the size=20
of the bio such that we'll never actually fail to bio_add_page(), but=20
this is still the right thing to do.

Reviewed-by: Chris Mason <clm@fb.com>

-chris
